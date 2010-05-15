(in-package :tthsum-test)

(defun to-base32 (x)
  (let ((code (binascii:encode x :base32)))
    (subseq code 0 (position #\= code))))

(defun do-test-tthsum (vector sha1 tth)
  (is (equal sha1 (to-base32 (digest-sequence :sha1 vector))))
  (is (equal tth (to-base32 (digest-sequence :tree-hash vector))))
  (values))

(defun test-tthsum ()
  (do-test-tthsum ;; The empty (zero-length) file:
      (make-array '(0) :element-type '(unsigned-byte 8))
    "3I42H3S6NNFQ2MSVX7XZKYAYSCX5QBYJ"
    "LWPNACQDBZRYXW3VHJVCJ64QBZNGHOHHHZWCLNQ")
  (do-test-tthsum ;; A file with a single zero byte:
      (make-array '(1) :element-type '(unsigned-byte 8) :initial-element 0)
    "LOUTZHNQZ74T6UVVEHLUEDSD63W2E6CP"
    "VK54ZIEEVTWNAUI5D5RDFIL37LX2IQNSTAXFKSA")
  (do-test-tthsum ;; A file with 1024 'A' characters:
      (make-array '(1024) :element-type '(unsigned-byte 8) :initial-element 65)
    "ORWD6TJINRJR4BS6RL3W4CWAQ2EDDRVU"
    "L66Q4YVNAFWVS23X2HJIRA5ZJ7WXR3F26RSASFA")
  (do-test-tthsum ;; A file with 1025 'A' characters:
      (make-array '(1025) :element-type '(unsigned-byte 8) :initial-element 65)
    "UUHHSQPHQXN5X6EMYK6CD7IJ7BHZTE77"
    "PZMRYHGY6LTBEH63ZWAHDORHSYTLO4LEFUIKHWY"))
