(defpackage rhythm-test
  (:use :cl
        :rhythm
        :prove))
(in-package :rhythm-test)

;; NOTE: To run this test file, execute `(asdf:test-system :rhythm)' in your Lisp.

(setf *enable-colors* nil)

(defun make-heart ()
  (make-instance 'heart
		 :name "test-heart"
		 :beat #'(lambda (heart times)
			   (format t "~a, ~a" heart times))))

(plan 8)

(subtest "heart"
  (let ((h (make-heart)))
    (is-type h 'heart)))

(subtest "life-p"
  (let ((h (make-heart)))
    (tune h 1)
    (ok (life-p h))
    (tune h 0)
    (is (life-p h) nil)))

(subtest "tune"
  (let ((h (make-heart)))
    (is (slot-value h 'bpm) 0)
    (ok (tune h 1))
    (is (slot-value h 'bpm) 1)
    (tune h 0)))

(subtest "name"
  (let ((h (make-heart)))
    (is (name h) "test-heart")))

(subtest "bpm"
  (let ((h (make-heart)))
    (is (bpm h) 0)
    (tune h 1)
    (is (bpm h) 1)
    (tune h 0)))

(subtest "beat"
  (let ((h (make-heart)))
    (is-type (beat h) 'function)
    (is-print (funcall (beat h) "test" "rhythm") "test, rhythm")))

(subtest "core"
  (let ((h (make-heart)))
    (tune h 1)
    (ok (core h))
    (tune h 0)))

(subtest "times"
  (let ((h (make-heart)))
    (ok (times h))
    (tune h 1)
    (sleep 1)
    (ok (> (times h) 0))
    (tune h 0)))
	
(finalize)
