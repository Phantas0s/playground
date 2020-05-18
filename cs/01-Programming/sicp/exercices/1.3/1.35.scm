; (define dx 0.00001)
; (define (close-enough? x y) 
;   (< (abs (- x y)) 0.001))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; (define (sqrt x)
;   (fixed-point (lambda (y) (/ x y))
;                1.0))

g^2 = g + 1
g = (g + 1) / g
g = g / g + (1 / g)
g = 1 + (1 / g)

x -> 1 + (1 / x)

(define (average x y) ( / (+ x y) 2))

(define (golden-ration)
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 
               1.0))

**PERFECT**
