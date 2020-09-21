; Devise a correct version of the count-pairs
; procedure of Exercise 3.16 that returns the number of dis-
; tinct pairs in any structure. (Hint: Traverse the structure,
; maintaining an auxiliary data structure that is used to keep
; track of which pairs have already been counted.)


(define a (list (list 'a) (list 'b)))

(define (count-pairs x)
  (define (cp x p)
    (if (or (not (pair? x)) (list-in-list? x p))
      0
      (let 
        ((np (cons x p)))
        (+ (cp (car x) np)
           (cp (cdr x) (cons (car x) np))
           1))))
  (cp x '()))

(define (list-in-list? s h)
  (cond ((empty? h) #f) 
        ((eq? s (car h)) #t) 
        (else (list-in-list? s (cdr h)))))


; first case

(define a (list 'a (list 'b)))
(count-pairs a)
; => 3

; second case 
(define a (list 1 2))
(count-pairs a)
; => 2

; third case

(define a (list 'a 'b))
(define z (list 1))
(set-car! a z)
(set-car! (cdr a) z)
(count-pairs a)
; => 3

; fourth case
(define a (list 1))
(define z (list 1))
(set-car! a z)
(set-car! z a)
(count-pairs a)
; => 2

; fifth case

(define a (list 1))
(define z (list 1 2))
(set-car! a z)
(set-cdr! a z)
(count-pairs a)
; => 3

;**GOOD**
