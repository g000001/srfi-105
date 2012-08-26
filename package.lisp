;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-105
  (:use)
  (:export))

(defpackage :srfi-105.internal
  (:use :srfi-105 :rnrs-user :named-readtables :fiveam))

