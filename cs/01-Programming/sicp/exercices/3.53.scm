; Without running the program, describe the
; elements of the stream defined by

(define s (cons-stream 1 (add-streams s s)))

; When we define s, we get back a stream with 1 as first value in the car and the promise (add-streams s s) in the cdr.

**GOOD**

; If we try to compute the premise, it will always return 1.

**WRONG**

; If we try to compute the premise with (stream-ref 1) for example, we get 2. It's because we add the stream s `(1 <premise>)` which gives the result `(2 <premise>)`. If we run (stream-ref 2) we get 4, as the stream `(2 <premise>)` is added to itself.

; We obtain a stream of the power of 2.

**GOOD**
