(defsystem :tthsum
  :description "Command-line program tthsum for cryptographic checksum"
  :long-description "This is a sample implementation of tthsum in CL,
computing the Tiger Tree Hash of given files, using ironclad for cryptography.
It is command-line compatible with the C implementation of tthsum."
  :depends-on (:ironclad :binascii :command-line-arguments :xcvb-driver :cl-launch)
  :components
  ((:file "main")))
