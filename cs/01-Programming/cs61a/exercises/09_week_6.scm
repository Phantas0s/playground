; write a map primitive for scheme-1 (call it map-1 so you and
; Scheme don’t get confused about which is which) that works correctly for all mapped
; procedures.

(define (map-1 fn args)
  (if (eq? args '())
    '()
    (cons (apply-1 fn (list (car args))) (map-1 fn (cdr args)))))

; Modify the scheme-1 interpreter to add the let special form. Hint: Like a procedure
; call, let will have to use substitute to replace certain variables with their values. Don’t
; forget to evaluate the expressions that provide those values!

(define let-exp? (exp-checker 'let))
(define (let-var let-exp) (map car (cadr let-exp)))
(define (let-val let-exp) (map cadr (cadr let-exp)))
(define (let-body let-exp) (caddr let-exp))

(define (eval-let exp)
    ;(apply-1 (list 'lambda (let-names exp) (let-body exp)) (map eval-1 (let-values exp))))
    (apply-1 (list 'lambda (let-var exp) (let-body exp)) (let-val exp)))
