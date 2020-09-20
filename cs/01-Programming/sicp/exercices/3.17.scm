; Devise a correct version of the count-pairs
; procedure of Exercise 3.16 that returns the number of dis-
; tinct pairs in any structure. (Hint: Traverse the structure,
; maintaining an auxiliary data structure that is used to keep
; track of which pairs have already been counted.)

(define (count-pairs x)
  (define (cp x p)
    (if (not (pair? x))
      0
      (let 
        ((np (cons x p)))
        (+ (cp (car x) np)
           (cp (cdr x) np)
           (list-in-list? p x)))))
  (cp x '()))

(define (list-in-list? h s)
  (if (empty? (map (lambda (x) (eq? x s)) h))
    1
    0))
