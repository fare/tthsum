#+xcvb (module ())

(in-package :cl-user)

(defpackage :tthsum
  (:use :ironclad :cl :command-line-arguments :binascii :uiop)
  (:shadowing-import-from :ironclad #:null))

(in-package :tthsum)

(defparameter *version* "1.2")

(defparameter +tthsum-option-spec+
  '(((#\b) :type boolean :optional t :documentation "do-nothing compatibility option")
    (("check" #\c) :type string :optional t :documentation "check files listed in specified file")
    (("verbose" #\v) :type boolean :optional t :documentation "be verbose (with -c)")
    (("warn" #\w) :type boolean :optional t :documentation "warn on badly formatted lines (with -c)")
    (("help" #\h) :type boolean :optional t :documentation "display help")
    (("version" #\V) :type boolean :optional t :documentation "display version")))

(defun main (args)
  (handle-command-line +tthsum-option-spec+ 'tthsum
                       :command-line args :name "tthsum" :rest-arity t))

(defun show-version ()
  (format t "tthsum, common-lisp version ~a~%" *version*))

(defun show-help ()
  (show-version)
  (command-line-arguments:show-option-help +tthsum-option-spec+ :sort-names t))

(defun show-tth (sum name)
  (format t "~a  ~a~%" (subseq (binascii:encode sum :base32) 0 39) name))

(defun tthsum (args &key b check verbose warn help version)
  (declare (ignore b))
  (cond
    (version
     (show-version))
    (help
     (show-help))
    (check
     warn verbose
     (error "NOT IMPLEMENTED YET"))
    (args
     (loop :for file :in args :do
       (if (probe-file file)
           (show-tth (digest-file :tree-hash file) file)
           (format *error-output* "file ~A does not exist~%" file))))
    (t
     (show-tth
      #.(or #+(and sbcl unix)
            '(digest-stream :tree-hash (sb-sys:make-fd-stream 0 :input t :element-type '(unsigned-byte 8)))
            ;; UGLY HACK: most CL implementations get confused by the apparent symlink
            ;; that is Linux's /dev/fd/0 aka /proc/self/fd/0, so instead we indirectly use it through cat...
            #+os-unix
            '(run-program '("cat") :input :interactive
              :element-type '(unsigned-byte 8)
              :output (lambda (stdin) (digest-stream :tree-hash stdin)))
            '(error "reading from stdin not supported on your platform"))
      "-"))))
