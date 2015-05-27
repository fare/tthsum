(asdf:defsystem :tthsum-test
  :version (:read-file-form "main.lisp" :at (3 2))
  :description "tests for tthsum"
  :author "Francois-Rene Rideau"
  :license "MIT"
  :depends-on (:tthsum :hu.dwim.stefil :flexi-streams)
  :serial t
  :components
  ((:file "test-package")
   (:file "tests")))
