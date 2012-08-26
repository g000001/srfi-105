;;;; readtable.lisp

(cl:in-package :cl-user)
(named-readtables:in-readtable :common-lisp)

(named-readtables:defreadtable :srfi-105  (:merge :standard)
  (:macro-char #\{ #'srfi-105.internal::|{-reader|)
  (:syntax-from :standard #\) #\})
  (:case :upcase))
