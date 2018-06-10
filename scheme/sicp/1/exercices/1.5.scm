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
