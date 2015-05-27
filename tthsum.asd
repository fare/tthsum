(defsystem "tthsum"
  :version (:read-file-form "main.lisp" :at (3 2))
  :description "Command-line program tthsum for cryptographic checksum"
  :long-description "This is a sample implementation of tthsum in CL,
computing the Tiger Tree Hash of given files, using ironclad for cryptography.
It is command-line compatible with the C implementation of tthsum."
  :author "Francois-Rene Rideau"
  :license "MIT"
  :depends-on ("ironclad" "binascii" "command-line-arguments" #-asdf3 "uiop")
  :components ((:file "main")))
