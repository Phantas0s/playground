; Define a procedure partial-sums that takes
; as argument a stream S and returns the stream whose ele-
; ments are S0 , S0 + S1 , S0 + S1 + S2 , . . .. For example, (partial-
; sums integers) should be the stream 1, 3, 6, 10, 15, ...

(define (partial-sums s) 
  (cons-stream (stream-car s) (add-streams (stream-cdr s) (partial-sums s)))) 

(define test (partial-sums integers))
(stream-ref test 0)
(stream-ref test 1)
(stream-ref test 2)
(stream-ref test 3)
(stream-ref test 4)
(stream-ref test 5)

; **GOOD**
; **TO REVIEW**

; other solution

(define (partial-sums s) 
  (define ps (add-streams s (cons-stream 0 ps))) 
  ps) 

; When you look at it, each element of the stream is the result of index + element just before (index - 1).
; We take s as base and add to it a shifted stream recursively.

; 1 2 3 4 5 (base)
; 0 1 2 3 4  (first recursion)
; 0 1 3  (second recursion)
; 0 1 3 6  (third recursion)
; 0 1 3 6 10  (fourth recursion)

; 1 3 6 10 15...

