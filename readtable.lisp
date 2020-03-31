;;;; readtable.lisp

(cl:in-package "https://github.com/g000001/srfi-105")


(named-readtables:in-readtable :common-lisp)


(defreadtable :srfi-105
  (:merge :standard)
  (:macro-char #\{ #'|{-reader|)
  (:syntax-from :standard #\) #\})
  (:case :upcase))


;;; *EOF*
