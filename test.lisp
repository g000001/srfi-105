(cl:in-package "https://github.com/g000001/srfi-105")


(in-readtable :srfi-105)


(def-suite* srfi-105)


(test :simple
  (is (= {3 + 3} 6))
  ;; {a * {b + c}} maps to (* a (+ b c))
  (is (equal '{a * {b + c}}
             '(* A (+ B C))))
  ;; {x eqv? `a} maps to (eqv? x `a) 
  (is (equal '{x eqv? `a} '(EQV? X `A)))
  ;; {(- a) / b} maps to (/ (- a) b)
  (is (equal '{(- a) / b} '(/ (- A) B)))
  ;; {(f a b) + (g h)} maps to (+ (f a b) (g h))
  (is (equal '{(f a b) + (g h)} '(+ (F A B) (G H))))
  ;; '{a + (f b) + x} maps to '(+ a (f b) x)
  (is (equal '{a + (f b) + x} '(+ A (F B) X)))
  ;; {{a > 0} and {b >= 1}} maps to (and (> a 0) (>= b 1))
  (is (equal '{{a > 0} and {b >= 1}} '(AND (> A 0) (>= B 1))))
  )


;;; *EOF*
