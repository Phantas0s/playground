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
