; In order to take a closer look at delayed eval-
; uation, we will use the following procedure, which simply
; returns its argument after printing it:

(define (show x) (display-line x) x)

; What does the interpreter print in response to evaluating
; each expression in the following sequence?

(define (stream-enumerate-interval low high) 
  (if (> low high) 
    the-empty-stream 
    (cons-stream low (stream-enumerate-interval (+ low 1) high)) ) ) 

(define x (stream-map show (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)

; We would have all the display just after defining x, then the other two stream reference would display 4 and 6.

**WRONG**

; This is utterly wrong. The point of a stream is NOT to compute all its elements. Only the first is returned, so the call to define will call show on the first element of the stream, 0.

(define x (stream-map show (stream-enumerate-interval 0 10)))
;0

; When stream-ref are called, every values from 0 to the final one are computed. 


(stream-ref x 5)
; 0 
; 1 
; 2 
; 3
; 4
; 5
(stream-ref x 7)
;6
;7

; The last stream-ref only show 6 and 7 thanks to memoization.
