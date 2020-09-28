; Exercise 1
; Write vector-append, which takes two vectors as arguments and returns a new vector
; containing the elements of both arguments, analogous to append for lists.

(define (vector-extend vec s)
  (define (loop newvec n)
    (if (= n 0)
      newvec
      (begin (vector-set! newvec (- n 1) (vector-ref vec (- n 1)))
             (loop newvec (- n 1)))))
  (loop (make-vector s) (vector-length vec)))

(define (vector-append v1 v2)
  (define (loop vec n)
    (if (= n 0)
      vec
      (begin 
        (vector-set! vec (+ (vector-length v2) (- n 1)) (vector-ref v2 (- n 1)))
        (loop vec (- n 1)))))
  (loop (vector-extend v1 (+ (vector-length v1) (+ (vector-length v2)))) (vector-length v2)))

; test

(define v (vector 1 2 3))
(define w (vector 4 5 6))
(vector-append v w)

**PERFECT**


; Exercise 2

; Write vector-filter, which takes a predicate function and a vector as arguments,
; and returns a new vector containing only those elements of the argument vector for which
; the predicate returns true. The new vector should be exactly big enough for the chosen
; elements. Compare the running time of your program to this version:
(define (vector-filter pred vec)
  (list->vector (filter pred (vector->list vec))))

(define (vector-filter pred vec)
  (define (count-el n tot)
    (if (= n (vector-length vec))
      tot
      (count-el (+ n 1) (if (pred (vector-ref vec n))
                          (+ tot 1)
                          tot))))
  (define (c newvec n t)
    (if (< t 0) 
      newvec
      (if (pred (vector-ref vec t)) 
        (begin (vector-set! newvec n (vector-ref vec t)) 
               (c newvec (- n 1) (- t 1)))
        (c newvec n (- t 1)))))
  (c (make-vector (count-el 0 0)) (- (count-el 0 0) 1) (- (vector-length vec) 1)))

;test 

(define v (vector 1 2 3))
(vector-filter (lambda (x) (> x 1)) v)
