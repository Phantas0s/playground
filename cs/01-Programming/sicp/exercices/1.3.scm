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
