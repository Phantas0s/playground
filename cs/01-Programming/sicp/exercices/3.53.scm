; Without running the program, describe the
; elements of the stream defined by

(define s (cons-stream 1 (add-streams s s)))

`(add-streams)` returns the empty-stream (s is null). If we cons 1 to the empty stream, we get a stream with the first value as 1 and a premise.

**GOOD**

 If we try to compute the premise, it will always return 1.

**WRONG**

If we try to compute the premise with (stream-ref 1) for example, we get 2. It's because we add the stream s `(1 <premise>)` to itself, which gives the result `(1 2 <premise>)`. If we run (stream-ref 2) we get 4, as the stream `(1 2 <premise>)` is added to itself.

We obtain a stream of the power of 2.

**GOOD**
