(asdf:defsystem :tthsum
  :depends-on (:ironclad :binascii :command-line-arguments :xcvb-driver :cl-launch)
  :components
  ((:file "main")))
