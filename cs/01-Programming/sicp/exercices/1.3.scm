; +----------------+
; |  EXERCISE 1.34 |
; +----------------+

; (define (f g) (g 2))
; What happens if we do (f f)?

; (f f) would expand to (f 2) which would expand to (2 2). At that point, the interpreter will throw an error
