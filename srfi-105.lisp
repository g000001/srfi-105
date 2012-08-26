;;;; srfi-105.lisp

(cl:in-package :srfi-105.internal)


; Return true if lyst has an even # of parameters, and the (alternating)
; first parameters are "op".  Used to determine if a longer lyst is infix.
; If passed empty list, returns true (so recursion works correctly).
(define-function (even-and-op-prefix? op lyst)
  (cond
    ((null? lyst) 'T)
    ((not (pair? lyst)) 'nil)
    ((not (eq? op (car lyst))) 'nil) ; fail - operators not the same
    ((not (pair? (cdr lyst)))  'nil) ; Wrong # of parameters or improper
    (else   (even-and-op-prefix? op (cddr lyst))))) ; recurse.

; Return true if the lyst is in simple infix format
; (and thus should be reordered at read time).
(define-function (simple-infix-list? lyst)
  (and
    (pair? lyst)           ; Must have list;  '() doesn't count.
    (pair? (cdr lyst))     ; Must have a second argument.
    (pair? (cddr lyst))    ; Must have a third argument (we check it
                           ; this way for performance)
    (symbol? (cadr lyst))  ; 2nd parameter must be a symbol.
    (even-and-op-prefix? (cadr lyst) (cdr lyst)))) ; true if rest is simple

; Return alternating parameters in a list (1st, 3rd, 5th, etc.)
(define-function (alternating-parameters lyst)
  (if (or (null? lyst) (null? (cdr lyst)))
    lyst
    (cons (car lyst) (alternating-parameters (cddr lyst)))))

; Not a simple infix list - transform it.  Written as a separate procedure
; so that future experiments or SRFIs can easily replace just this piece.
(define-function (transform-mixed-infix lyst)
   (cons 'nfx lyst))

; Given curly-infix lyst, map it to its final internal format.
(define-function (process-curly lyst)
  (cond
   ((not (pair? lyst)) lyst) ; E.G., map {} to ().
   ((null? (cdr lyst)) ; Map {a} to a.
     (car lyst))
   ((and (pair? (cdr lyst)) (null? (cddr lyst))) ; Map {a b} to (a b).
     lyst)
   ((simple-infix-list? lyst) ; Map {a OP b [OP c...]} to (OP a b [c...])
     (cons (cadr lyst) (alternating-parameters lyst)))
   (else  (transform-mixed-infix lyst))))

; In the reader, when #\{ is detected, read (as a list) from that port
; until its matching #\}, then process that list with "process-curly".

(define-function (|{-reader| stream char)
  (declare (ignore char))
  (process-curly (cl:read-delimited-list #\} stream 'T)))


;;; eof
