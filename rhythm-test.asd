#|
  This file is a part of rhythm project.
|#

(defsystem "rhythm-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Satoshi Iwasaki (yanqirenshi@gmail.com)"
  :license "LLGPL"
  :depends-on ("rhythm"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "rhythm"))))
  :description "Test system for rhythm"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
