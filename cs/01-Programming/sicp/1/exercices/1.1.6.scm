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


