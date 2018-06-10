; pretty print

(+ ( * 3
    (+ (* 2 4)
       (+ 3 5 )))
   (+ (- 10 7)
      6))

; Procedure definitions
(define (square x) (* x x))
(define (sum-of-squares x y)
(+ (square x)(square y)))

; Conditional expression and predicates
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0)(- x))))
; Inside parenthesis -> predicate (procedures evaluated as true or false)
; predicates can be expressions such as <, >, =

; ((= x 0) 0) -> clause

(define (abs x)
  (if (< x 0)
    (- x)
    x))

(define (>= x y)
  (not (< x y)))

(define (>= x y)
  (or (> x y)(= x y)))
