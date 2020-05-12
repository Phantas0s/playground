; +------------------+
; |  EXERCISE 1.31.1 |
; +------------------+

; (define (sum term a next b)
;   (if (> a b)
;       0
;       (+ (term a)
;          (sum term (next a) next b))))

(define (product term a next b)
  (if (> a b)
    1
    (* (term a)
       (product term (next a) next b))))

**PERFECT**

(define (factorial a b) (product identity a inc b))

; [2n/(2n – 1)][2n/(2n + 1)]

**PERFECT**

**WALLIS FORMULA SKIPPED**

; +------------------+
; |  EXERCISE 1.31.2 |
; +------------------+

**SKIPPED**

; +-------------------+
; |  EXERCISE 1.32.1  |
; +-------------------+

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (next a) next b))))

(define (sum term a next b) 
  (accumulate + 0 term a next b))

(define (product term a next b) 
  (accumulate * 1 term a next b))

**PERFECT**

; +-------------------+
; |  EXERCISE 1.32.2  |
; +-------------------+

**SKIPPED**

; +----------------+
; |  EXERCISE 1.33 |
; +----------------+

(define (filter-accumulate predicate combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((predicate a) (combiner (term a)
                                 (filter-accumulate predicate combiner null-value term (next a) next b)))
        (else (combiner null-value 
                        (filter-accumulate predicate combiner null-value term (next a) next b)))))

(define (sum-squares-prime a b) 
  (filter-accumulate prime? + 0 identity a inc b))

(define (product-relative-prime b) 
  (filter-accumulate (lambda (a) (equal? (gcd a b) 1)) * 1 identity 0 inc b))

**PERFECT**

; +----------------+
; |  EXERCISE 1.34 |
; +----------------+

; (define (f g) (g 2))
; What happens if we do (f f)?

; (f f) would expand to (f 2) which would expand to (2 2). At that point, the interpreter will throw an error

; +---------------+
; | Exercise 1.40 |
; +---------------+

; (define dx 0.00001)
; (define (close-enough? x y) 
;   (< (abs (- x y)) 0.001))

; (define (fixed-point f first-guess)
;   (define (close-enough? v1 v2)
;     (< (abs (- v1 v2)) 
;        tolerance))
;   (define (try guess)
;     (let ((next (f guess)))
;       (if (close-enough? guess next)
;           next
;           (try next))))
;   (try first-guess))

; (define (deriv g)
;   (lambda (x)
;     (/ (- (g (+ x dx)) (g x))
;        dx)))


; (define (newton-transform g)
;   (lambda (x)
;     (- x (/ (g x) 
;             ((deriv g) x)))))

; (define (newtons-method g guess)
;   (fixed-point (newton-transform g) 
;                guess))

(define (cube x) (* x x x))
(define (cubic a b c) (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

**PERFECT**

; +---------------+
; | Exercise 1.41 |
; +---------------+

(define (double p) (lambda (x) (p (p x))))

(((double (double double)) inc) 5)

; Going inward to outward: (double double) will double a double, so 2^2 execution of the argument procedure.
; Executing double on it will do 2^(2*2) execution 2^4 execution of the argument procedure.
; Therefore, inc will be executed 16 times. The result is 5 + 16 = 21
; It means that something like (((double (double (double double))) inc) 5) will execute inc 2^(2*2*2) = 256 times!

; +---------------+
; | Exercise 1.43 |
; +---------------+

; ((repeated square 2) 5) 
; => 625

(define (repeated p n)
  (define (sub p n x)
    (if (= n 0)
      x
      (p (sub p (- n 1) x))))
  (lambda (x) (sub p n x)))

**GOOD**

; +---------------+
; | Exercise 1.46 |
; +---------------+

(define (iterative-improve good-enough? improve)
  (define (sub-improve guess)
    (if (good-enough? guess)
      guess
      (sub-improve (improve guess))))
  (lambda (guess) (sub-improve guess)))

; (define (improve guess x)
;   (average guess (/ x guess)))

; (define (good-enough? guess x)
;   (< (abs (- (square guess) x)) 0.001))

; (define (sqrt-iter guess x)
;   (if (good-enough? guess x)
;     guess
;     (sqrt-iter (improve guess x) x))) 

; (define (sqrt x)
;   (sqrt-iter 1.0 x))

(define (sqrt x)
    ((iterative-improve 
     good-enough? 
     (lambda (x) (improve x 1.0))) x)
