; +---------------+
; |  EXERCISE 1.6 |
; +---------------+

; With this new form of if, the consequent and alternative will be evaluated as well as the predicate.
; Since the alternative has a recursion the program will never stop

; **PERFECT**

; ======= solution found on internet

; The default if statement is a special form which means that even when an interpreter follows applicative substitution, it only evaluates one of it's parameters- not both. However, the newly created new-if doesn't have this property and hence, it never stops calling itself due to the third parameter passed to it in sqrt-iter. 

; +---------------+
; |  EXERCISE 1.7 |
; +---------------+

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

**GOOD**
