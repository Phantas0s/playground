(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

; +---------------+
; | Exercise 2.12 |
; +---------------+

(define (make-center-percent c p)
  (make-interval (- c (* c (/ p 100))) (+ c (* c (/ p 100 )))))
(define (percent i)
    (* (- (center i) (lower-bound i)) (/ 100 (center i))))

**GOOD**
