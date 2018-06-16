;square cube
;(x/(y*y) + 2y) / 3
;

(define (square x)(* x x))
(define (cube x)(* x x x))

(define (sqrt-iter old guess x)
  (if (good-enough? old guess x)
    guess
    (sqrt-iter guess (average guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average y x)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

(define (good-enough? old guess x)
  (< (abs(- guess old)) 0.000000001))

(define (sqrt x)
(sqrt-iter 0 1.0 x))
