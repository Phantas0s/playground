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

; **PERFECT**

; +---------------+
; | Exercise 2.8: |
; +---------------+

(define (sub-interval x y)
  (let ((fi (abs (- (lower-bound x) (lower-bound y))))
        (si (abs (- (upper-bound x) (upper-bound y)))))
    (make-interval (min fi si)
                   (max fi si))))
; **WRONG**
; doesn't work for negative interval

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

; **WRONG** 

; +---------------+
; | Exercise 2.10 |
; +---------------+


(define (div-interval x y)
  (let ((upper-bound-y (upper-bound y))
        (lower-bound-y (lower-bound y)))
    (if (or (= upper-bound-y 0) (= lower-bound-y 0))
      (display "ERROR: can't divide by 0")
      (mul-interval
        x
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y)))))))

; **WRONG?**
; span 0 is 0 as "space" of two interfaces, like (make-interval -1 1)
