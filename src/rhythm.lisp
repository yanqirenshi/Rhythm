(defpackage rhythm
  (:use :cl)
  (:import-from :bordeaux-threads
                #:make-thread)
  (:export #:heart
           #:start
           #:stop
           #:life-p)
  (:export #:name
           #:bpm
           #:beat
           #:core
           #:times))
(in-package :rhythm)

(defclass heart ()
  ((name  :accessor name  :initarg :name  :initform nil :type 'string)
   (bpm   :accessor bpm   :initarg :bpm   :initform 1   :type 'number)
   (beat  :accessor beat  :initarg :beat  :initform nil :type 'function)
   (core  :accessor core  :initarg :core  :initform nil)
   (times :accessor times :initarg :times :initform 0   :type 'number)))

(defgeneric life-p (heart)
  (:method ((heart heart))
    (handler-case
        (progn
          (not (null (> (bpm heart) 0))))
      (error nil))))

(defgeneric tick-times (heart)
  (:method ((heart heart))
    (setf (times heart)
          (if (= 88888888 (times heart))
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

(defmacro start (heart)
  `(setf (core ,heart)
         (make-thread #'(lambda ()
                          (do ()
                              ((not (life-p ,heart)) ,heart)
                            (tick ,heart)
                            (sleep (bpm ,heart))))
                      :name (core-name ,heart))))

(defmacro stop (heart)
  `(when ,heart
     (setf (bpm ,heart) 0)))
