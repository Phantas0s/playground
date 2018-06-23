(define (a-plus-abs-b a b)
((if (> b 0) + -) a b))

; if b > 0, the return will be (+ a b), otherwise (- a -b) equivalent to (+ a b)
