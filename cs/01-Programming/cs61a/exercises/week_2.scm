; +------------+
; | Exercise 1 |
; +------------+

; 1. Abelson & Sussman, exercises 1.31(a), 1.32(a), 1.33, 1.40, 1.41, 1.43, 1.46

; +------------+
; | Exercise 2 |
; +------------+

; > (every square ’(1 2 3 4))
; (1 4 9 16)
; > (every first ’(nowhere man))
; (n m)

(define (every f s)
  (if (empty? s)
    '()
    (se (f (first s)) (every f (bf s)))))

**PERFECT**

