 ; Two lists are said to be equal? if they con-
; tain equal elements arranged in the same order. For exam-
; ple,

; (equal? '(this is a list) '(this is a list))

; is true, but

; (equal? '(this is a list) '(this (is a) list))

; is false. To be more precise, we can define equal? recur-
; sively in terms of the basic eq? equality of symbols by say-
; ing that a and b are equal? if they are both symbols and
; the symbols are eq?, or if they are both lists such that (car
; a) is equal? to (car b) and (cdr a) is equal? to (cdr b).
; Using this idea, implement equal? as a procedure.36

(define (equal? f s)
   (cond ((not (= (count f) (count s))) #f)
         ((empty? f) #t)
         ((and (list? (car f)) (list? (car s)))
          (if (equal? (car f) (car s))
            (equal? (cdr f) (cdr s))
            #f))
         ((eq? (car f) (car s)) (equal? (cdr f) (cdr s)))
         (else #f)))

 **GOOD**

 ; It works but it's not the most elegant...

 ; this solution is way better

 ; (define (equal2? a b) 
 ;   (if (and (pair? a) (pair? b)) 
 ;       (and (equal2? (car a) (car b)) (equal2? (cdr a) (cdr b))) 
 ;       (eq? a b))) 
