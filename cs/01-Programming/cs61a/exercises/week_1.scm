; +------------+
; | exercise 1 |
; +------------+

; see ../../sicp/exercices/1.1.scm

; +------------+
; | exercise 2 |
; +------------+

(define (squares nums)
  (if (empty? nums)
             '()
             (se (square (first nums)) (squares (bf nums)))))


; +------------+
; | exercise 3 |
; +------------+

(define (switch s)
  (if (empty? s) 
    '()
    (se (change-word (first s))
        (switch (bf s)))))

(define (change-word w)
  (cond ((equal? w 'I) 'you)
        ((equal? w 'i) 'you)
        ((equal? w 'me) 'you)
        ((equal? w 'you) 'me)
        ((equal? w 'You) 'i)
        (else w)))

; +------------+
; | exercise 4 |
; +------------+

(define (ordered? s)
(cond ((equal? (length s) 1) true)
      ((> (first s) (second s)) false)
      (else (ordered? (bf s)))))

; +------------+
; | exercise 5 |
; +------------+

(define (ends-e s)
  (cond ((empty? s) '())
        ((equal? (last (first s)) 'e) (se (first s) (ends-e (bf s))))
        (else (ends-e (bf s)))))
