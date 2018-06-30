(define (square x) (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (expt-iter b n) (fast-expt-iter 1 b n))
(define (fast-expt-iter a b n)
  (cond ((= n 0) b)
  ((even? n) (fast-expt-iter a (square b) (/ n 2)))
  (else (fast-expt-iter (* a b) b (- n 1)))))



; (Hint: Using the observation that (b n/2 ) 2 = (b 2 ) n/2 , keep,
; along with the exponent n and the base b, an additional
; state variablea, and define the state transformation in such
; awaythattheproductab n isunchangedfromstatetostate.
; At the beginning of the process a is taken to be 1, and the
; answer is given by the value of a at the end of the process.
; In general, the technique of defining an invariant quantity
; that remains unchanged from state to state is a powerful
; way to think about the design of iterative algorithms.)

; 1 2 3
; 2 2 2
; 2 4 1
; => 8

; 1 2 7
; 2 2 6
; 2 4 3
; 8 4 2
; 8 16 1
; => 128
