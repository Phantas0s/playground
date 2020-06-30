;; Scheme calculator -- evaluate simple expressions

; The read-eval-print loop:

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (calc)
  (display "calc: ")
  ; (flush)
  (print (calc-eval (read)))
  (calc))

; Evaluate an expression:

(define (calc-eval exp)
  (cond ((or (number? exp) (word? exp)) exp)
        ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
        (else (error "Calc: bad expression:" exp))))

; Apply a function to arguments:

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + 0 args))
        ((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
                           ((= (length args) 1) (- (car args)))
                           (else (- (car args) (accumulate + 0 (cdr args))))))
        ((eq? fn '*) (accumulate * 1 args))
        ((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
                           ((= (length args) 1) (/ (car args)))
                           (else (/ (car args) (accumulate * 1 (cdr args))))))
        ((or (eq? fn 'first) (eq? fn 'butfirst) (eq? fn 'last) (eq? fn 'butlast) (eq? fn 'word)) (apply (eval fn) args))
        (else (error "Calc: bad operator:" fn))))


; Extend the calculator program from lecture to include words as data, providing the
; operations first, butfirst, last, butlast, and word. Unlike Scheme, your calculator
; should treat words as self-evaluating expressions except when seen as the operator
; of a compound expression. That is, it should work like these examples:

; calc: foo
; foo
; calc: (first foo)
; f
; calc: (first (butfirst hello))
; e

**GOOD**

; Not sure if it's the intended solution though; we could as well convert word to list but no clue how to do that
