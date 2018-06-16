;
; √x = the y such that y ≥ 0 and y 2 = x.
;

(define (square x)(* x x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
(sqrt-iter 1.0 x))

; For small number like 0,00001 the absolute tolerance of 0.001 is too large. For large number like 10000000000000000000000000000000 the tolerance is too small resulting in an infinite of iteration because of the recursion...

(define (square x)(* x x))

(define (sqrt-iter old guess x)
  (if (good-enough? old guess x)
    guess
    (sqrt-iter guess (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? old guess x)
  (< (abs(- guess old)) 0.000000001))

(define (sqrt x)
(sqrt-iter 10.0 1.0 x))
