; Exercise 4.3: Rewrite eval so that the dispatch is done
; in data-directed style. Compare this with the data-directed
; differentiation procedure of Exercise 2.73. (You may use the
; car of a compound expression as the type of the expres-
; sion, as is appropriate for the syntax implemented in this
; section.)

; original

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type: EVAL" exp))))


(define (install-eval)
  (define self-evaluating (lambda (exp env) (exp)))
  (define lookup-variable-value (lambda (exp env) (lookup-variable-value exp env)))
  (define variable (lambda (exp env) (lookup-variable-value exp env)))
  (define quoted (lambda (exp env) (text-of-quotation exp)))
  (define assignment (lambda (exp env) (eval-assignment exp env)))
  (define definition (lambda (exp env) (eval-definition exp env)))
  (define if (lambda (exp env) (eval-if exp env)))
  (define lambda-exp (lambda (exp env) (make-procedure (lambda-parameters)
                                                   (lambda-body exp)
                                                   (env))))
  (define begin-exp (lambda (exp env) (eval-sequence (begin-action exp)
                                                   (env))))
  (define cond-exp (lambda (exp env) (eval 'if (cond->if exp) env)))
  (define application (lambda (exp env) (apply (eval (type exp) (operator exp) env)
                                               (list-of-values (operands exp) env))))
  (put 'eval '(self-evaluating) self-evaluating)
  (put 'eval '(variable) lookup-variable-value)
  (put 'eval '(quoted) quoted)
  (put 'eval '(assignment) assignment)
  (put 'eval '(definition) definition)
  (put 'eval '(if) if)
  (put 'eval '(lambda) lambda-exp)
  (put 'eval '(begin) begin-exp)
  (put 'eval '(cond) cond-exp)
  (put 'eval '(application) application))

(define (eval exp env)
  ((get 'eval '(tag exp)) exp env))

; **GOOD**

; We can add potentially here whatever operation we want to every type we define. Here we only have the operation eval to evaluate the type.
