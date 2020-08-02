; Trace in detail how a simple procedure call such as

((lambda (x) (+ x 3)) 5)

; 1. The input is read and passed to eval-1 (and quoted)
; 2. This is a pair containing a list and a number, so we call apply
; 3. Eval is called again with the car of the pair, which is a lambda.
; 4. The cdr 5 is passed to eval-1 as well (using map). It's a constant, so 5 is returned
; 5. apply-1 is called with argument:
    ; * '(lambda (x) (+ x 3))
    ; * 5
; 6. proc is a lambda, so substitute is called on it.
    ; * exp = '(+ x 3)
    ; * params = 'x
    ; * args = 5
    ; * bound = '()
; 7. Map is called on a new lambda (the else of the cond) and substitute is called again three time, with exp the value of each member of the list (+ x 3) and params, with
    ; * params = 'x'
    ; * args = 5
    ; * bound = '()
; 8. The first call to substitute has the symbol '+ as exp
; 9. look-up is called with '+ (and params + args)
; 10. Maybe-quote is called
; 11. It's a procedure so it's returned
; ?????

