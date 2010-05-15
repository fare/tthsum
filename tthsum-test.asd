(asdf:defsystem :tthsum-test
  :depends-on (:tthsum :hu.dwim.stefil :flexi-streams)
  :serial t
  :components
  ((:file "test-package")
   (:file "tests")))
