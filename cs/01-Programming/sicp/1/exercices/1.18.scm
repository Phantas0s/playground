(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

(define (double a) (+ a a))
(define (halve a) (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (* a b) (multiply 0 a b))
(define (multiply z a b)
  (cond ((= b 0) z)
    ((even? b) (multiply z (double a) (halve b)))
    (else (multiply (+ z a) a (- b 1)))))

; (0 3 4)
; (multiply 0 6 2)
; (multiply 0 12 1)
; (multiply 12 12 0)
; 12

; (0 4 5)
; (multiply 4 4 4)
; (multiply 4 8 2)
; (multiply 4 16 1)
; (multiply 20 16 0)
; 20
