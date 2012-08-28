;;;; srfi-105.asd -*- Mode: Lisp;-*- 

(cl:in-package :asdf)

(defsystem :srfi-105
  :serial t
  :depends-on (:fiveam
               :named-readtables
               :rnrs-compat
               :named-readtables)
  :components ((:file "package")
               (:file "srfi-105")
               (:file "readtable")
               (:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-105))))
  (load-system :srfi-105)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-105.internal :srfi-105))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

