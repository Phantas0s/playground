; +---------------+
; |  EXERCISE 1.1 |
; +---------------+

; 10
10
; (+ 5 3 4)
12
; (- 9 1)
8
; (/ 6 2)
3
; (+ (* 2 4) (- 4 6))
6
; (define a 3)
; (define b (+ a 1))
; (+ a b (* a b))
19
; (= a b)
#f
; (if (and (> b a) (< b (* a b)))
; b
; a)
4
; (cond ((= a 4) 6)
; ((= b 4) (+ 6 7 a))
; (else 25))
16
; (+ 2 (if (> b a) b a))
6
; (* (cond ((> a b) a)
; ((< a b) b)
; (else -1))
; (+ a 1))
16

; **PERFECT**

; +---------------+
; |  EXERCISE 1.2 |
; +---------------+


(/ 
  (+ (+ 5 4)
     (- 2 (- 3 (+ 6 (/ 4 5))))) 
  (* 3 
     (- 6 2) 
     (- 2 7)))

; **PERFECT**

; +--------------+
; | EXERCISE 1.3 |
; +--------------+

(define (square x) (* x x))
(define (add-square x y)(+ (square x)(square y)))
(define (lns a b c)
  (cond 
    ((and (> a c)(> b c)) (add-square a b))
    ((and (> a b)(> c b)) (add-square a c))
    ((and (> c b)(> b a)) (add-square c b))
    ((and (> c a)(> c b)) (add-square a b))
    ((and (> b a)(> b c)) (add-square a c))
    ((and (> b c)(> a b)) (add-square c b))
    ((and (> c a)(> b c)) (add-square a b))
    ((and (> b a)(> c b)) (add-square a c))
    ((and (> b c)(> b a)) (add-square c b))
    ((and (> a c)(= a b)) (add-square a b))
    ((and (> b a)(= b c)) (add-square b c))
    ((and (= c b)(= c a)) (add-square a c))))

; doesn't work in case (lns 3 2 2)
; **WRONG**

; +--------------+
; | EXERCISE 1.4 |
; +--------------+

(define (a-plus-abs-b a b)
((if (> b 0) + -) a b))

; if b > 0, the return will be (+ a b), otherwise (- a -b) equivalent to (+ a b)

; **GOOD**

; +--------------+
; | EXERCISE 1.5 |
; +--------------+

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

; Normal order
; Everything is expended
; (test 0 (p))
; (if (= x 0) 0 (p))
; 0

; Applicative order
; (test 0 (p))
; p is infinetely expended to itself and the program never terminate

; **PERFECT**

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
