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

; fibonacci
; recursive 

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(fib 6)
(+ (fib (5)) (fib(4)))
(+ (+(fib 4) (fib(3)) (+ fib(3)) (fib(2))))
(+ (+ (+ (fib 3) (fib 2)) (+ fib(2) (fib(1)) (+ (fib(3) (fib 2)) (+ (fib(1) (fib 0)))))))

; iterative
(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
    b
    (fib-iter (+ a b) a (- count 1))))
