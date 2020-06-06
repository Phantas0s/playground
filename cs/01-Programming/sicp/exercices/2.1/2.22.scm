; +---------------+
; | Exercise 2.22 |
; +---------------+

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items nil))

; The answer list is in reverse order because cons prepand the new square in the list.

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items nil))

; cons this time will prepand the list answer to the new result, which will return something like ('('('())) new-square)...

**PERFECT**
