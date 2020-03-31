;;;; srfi-105.asd -*- Mode: Lisp;-*- 

(cl:in-package :asdf)


(defsystem :srfi-105
  :version "20200401"
  :description "SRFI 105 for CL: Curly-infix-expressions"
  :long-description "SRFI 105 for CL: Curly-infix-expressions
https://srfi.schemers.org/srfi-105"
  :author "David A. Wheeler and Alan Manuel K. Gloria"
  :maintainer "CHIBA Masaomi"
  :serial t
  :depends-on (fiveam
               named-readtables
               rnrs-compat)
  :components ((:file "package")
               (:file "srfi-105")
               (:file "readtable")
               (:file "test")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-105))))
  (let ((name "https://github.com/g000001/srfi-105")
        (nickname :srfi-105))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-105))))
  (let ((*package*
         (find-package "https://github.com/g000001/srfi-105")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-105)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
