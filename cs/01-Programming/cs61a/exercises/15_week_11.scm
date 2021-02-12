; Write and test two functions to manipulate nonnegative proper fractions. The first
; function, fract-stream, will take as its argument a list of two nonnegative integers, the
; numerator and the denominator, in which the numerator is less than the denominator. It
; will return an infinite stream of decimal digits representing the decimal expansion of the
; fraction. The second function, approximation, will take two arguments: a fraction stream
; and a nonnegative integer numdigits. It will return a list (not a stream) containing the
; first numdigits digits of the decimal expansion.

; (fract-stream (1 7)) should return the stream representing the decimal expansion of
; 1/7, which is 0.142857142857142857...

; (stream-car (fract-stream '(1 7))) should return 1.
; (stream-car (stream-cdr (stream-cdr (fract-stream '(1 7))))) should return 2.
; (approximation (fract-stream '(1 7)) 4) should return (1 4 2 8)
; (approximation (fract-stream '(1 2)) 4) should return (5 0 0 0)


