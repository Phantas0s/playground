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

; **PERFECT**

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

; **GOOD(?)**

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

; **PERFECT**

; +------------+
; | exercise 6 |
; +------------+

(define (logical-operator-evaluation)
  (or (= 1 1) (logical-operator-evaluation))
  (and (= 0 1) (logical-operator-evaluation)))

; If and / or follow an applicative order, this function will never end...
; It's good for performance reasons to only evaluate the args of or / and one at a time. No need to evaluate everything
; I don't see any advantage to treat or as an ordinary function, except maybe to catch potential error in running code otherwise not catch if the code is never executed...
