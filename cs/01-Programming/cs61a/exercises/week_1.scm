; +------------+
; | exercise 1 |
; +------------+

; see ../../sicp/exercices/1.1.scm

; +------------+
; | exercise 2 |
; +------------+

(define (squares s)
  (if (empty? s)
             s
             (squares (sentence (square (first s)) (bf(s))))))



