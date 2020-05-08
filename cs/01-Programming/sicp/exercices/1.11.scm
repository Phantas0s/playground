; recursive
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

; iterative
(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
    b
    (fib-iter (+ a b) a (- count 1))))

; f (n) =
; n if n < 3,
; f (n − 1) + 2f (n − 2) + 3f (n − 3) if n ≥ 3.
(define (tree-rec n)
  (if (< n 3)
    n
    (+ (tree-rec (- n 1))
       (* 2 (tree-rec (- n 2)))
       (* 3 (tree-rec (- n 3))))))


(define (tree n)
  (tree-iter 0 1 2 n))

; Didn't come up with this solution no clue about maths :'(
; Did find the tree procedure arguments, the count -1 and the fact that somehow something had to be done :D
(define (tree-iter a b c count)
  (if (= count 0)
    a
    (fib-iter b c (+ c (* 2 b) (* 3 a)) (count - 1))))
