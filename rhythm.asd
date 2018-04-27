#|
  This file is a part of rhythm project.
|#

(defsystem "rhythm"
  :version "0.1.0"
  :author "Satoshi Iwasaki (yanqirenshi@gmail.com)"
  :license "LLGPL"
  :depends-on (:bordeaux-threads)
  :components ((:module "src"
                :components ((:file "rhythm"))))
  :description "Simple Metronome"
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "rhythm-test"))))
