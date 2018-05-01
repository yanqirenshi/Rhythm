(defpackage rhythm
  (:use :cl)
  (:import-from :bordeaux-threads
                #:make-thread)
  (:export #:heart
           #:make-heart
           #:life-p
           #:tune)
  (:export #:name
           #:bpm
           #:beat
           #:core
           #:times))
(in-package :rhythm)

(defclass heart ()
  ((name  :accessor name  :initarg :name  :initform nil :type 'string)
   (bpm   :accessor bpm                   :initform 0   :type 'number)
   (beat  :accessor beat  :initarg :beat  :initform nil :type 'function)
   (core  :accessor core  :initarg :core  :initform nil)
   (times :accessor times :initarg :times :initform 0   :type 'number)))

(defvar *counter-max* 88888888)

(defgeneric life-p (heart)
  (:method ((heart heart))
    (handler-case
        (progn
          (not (null (> (bpm heart) 0))))
      (error nil))))

(defgeneric tick-times (heart)
  (:method ((heart heart))
    (setf (times heart)
          (if (= *counter-max* (times heart))
              1
              (+ 1 (times heart))))))

(defgeneric tick (heart)
  (:method ((heart heart))
    (tick-times heart)
    (let ((beat (beat heart)))
      (when beat
        (funcall beat heart (times heart))))))

(defgeneric core-name (heart)
  (:method ((heart heart))
    (if (or (null (name heart))
            (= 0 (length (string-trim '(#\Space #\Tab #\Newline)
                                      (princ-to-string (name heart))))))
        (format nil "~a" heart)
        (format nil "~a, ~a" (name heart) heart))))

(defun make-thread-core (heart)
  #'(lambda ()
      (do ()
          ((not (life-p heart)) heart)
        (tick heart)
        (sleep (bpm heart)))))

(defun make-heart (&key name core)
  (make-instance 'heart :name name :beat core))

(defgeneric start (heart)
  (:method ((heart heart))
    (when (core heart)
      (assert (not (bordeaux-threads:thread-alive-p (core heart)))
              (heart)
              "Exist heart core. core=~a" (core heart)))
    (assert (not (null (bpm heart))) () "BPM is Empty")
    (assert (< 0 (bpm heart)) () "BPM < 0")
    (setf (core heart)
          (make-thread (make-thread-core heart)
                       :name (core-name heart)))
    heart))

(defgeneric stop (heart)
  (:method ((heart heart))
    (when heart
      (setf (bpm heart) 0))
    heart))

(defgeneric tune (heart bpm)
  (:method ((heart heart) (bpm number))
    (assert (>= bpm 0))
    (let ((new-bpm bpm)
          (old-bpm (bpm heart)))
      (setf (bpm heart) new-bpm)
      (cond ((and (= 0 new-bpm) (< 0 old-bpm)) (stop heart))
            ((and (< 0 new-bpm) (= 0 old-bpm)) (start heart))
            (t heart)))))
