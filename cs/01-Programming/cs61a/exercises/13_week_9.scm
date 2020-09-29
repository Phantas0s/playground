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

**GOOD ENOUGH**

; the time complexity for both solution is Big Theta of n.

; Exercise 3

;
; (a) Write bubble-sort!, which takes a vector of numbers and rearranges them to be in
; increasing order. (You’ll modify the argument vector; don’t create a new one.) It uses the
; following algorithm:

; [1] Go through the array, looking at two adjacent elements at a time, starting with elements
; 0 and 1. If the earlier element is larger than the later element, swap them. Then look at
; the next overlapping pair (0 and 1, then 1 and 2, etc.).

; [2] Recursively bubble-sort all but the last element (which is now the largest element).

; [3] Stop when you have only one element to sort.

; (b) Prove that this algorithm really does sort the vector. Hint: Prove the parenthetical
; claim in step [2].

; (c) What is the order of growth of the running time of this algorithm?

(define (bubble-sort! vec)
  (define (pass n)
    (if (= n (- (vector-length vec) 1))
      vec
      (begin (cond ((> (vector-ref vec n) (vector-ref vec (+ n 1)))
                    (let ((firstval (vector-ref vec n)))
                      (vector-set! vec n (vector-ref vec (+ n 1)))
                      (vector-set! vec (+ n 1) firstval))))
             (pass (+ n 1)))))

  (define (multipass n)
    (if (= n 0)
      vec
      (begin (pass 0)
             (multipass (- n 1)))))
  (multipass (vector-length vec)))

;test 

(define v (vector 4 2 1 3))
(vector-filter (lambda (x) (> x 1)) v)

; This algorithm has a quadratic time of complexity.
