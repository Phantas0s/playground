(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))


(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))


(define (div-interval x y)
  (mul-interval
    x
    (make-interval (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y)))))

; +-------------+
; | Execise 2.7 |
; +-------------+

(define (make-interval a b) (cons a b))
(define (upper-bound interval)
  (car interval))
(define (lower-bound interval)
  (cdr interval))

; **GOOD**
; Would work if a is ALWAYS upper-bound and b always lower-bound. 
; This is not clear in the book, but it would be better if both could be inversed.

; here's another solution, more flexible

(define (upper-bound interval)
  (max (car interval) (cdr interval)))
(define (lower-bound interval)
  (min (car interval) (cdr interval)))
