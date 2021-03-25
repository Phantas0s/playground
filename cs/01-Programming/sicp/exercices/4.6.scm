; let expressions are derived expressions, because

; (let ((⟨var1⟩ ⟨exp1⟩) . . . (⟨varn⟩ ⟨expn⟩))
; ⟨body⟩)

; is equivalent to

; ((lambda (⟨var1⟩ . . . ⟨varn⟩)
; ⟨body⟩)
; ⟨exp1⟩
; . . .
; ⟨expn⟩)

; Implement a syntactic transformation let->combination
; that reduces evaluating let expressions to evaluating com-
; binations of the type shown above, and add the appropriate
; clause to eval to handle let expressions.

(define (let? exp) (tagged-list? exp 'let))
(define (separate l index vars exps needed)
  (cond ((empty? l) (if (equal? needed 'vars)
                      vars
                      exps))
        ((equal? (modulo index 2) 0) (separate (cdr l) (+ index 1) (append vars (list (car l))) exps needed))
        (else  (separate (cdr l) (+ index 1) vars (append exps (list (car l)))needed))))

(define (let-vars exp)
  (separate (cadr exp) 1 '() '() 'vars))
(define (let-exps exp)
  (separate (cadr exp) 1 '() '() 'exps))
(define (let-body exp)
  (cddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (let->combination exp)
  (cons (make-lambda (let-exps exp) (let-body exp)) (let-vars exp)))

; TESTS

(let->combination 
  (list 'let (list 'a 1 'b 2) (list '+ 'a 'b)))

(let->combination 
  (list 'let (list 'a (list '+ 1 1) 'b (list '+ 2 2)) (list '+ 'a 'b)))

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((let? exp) (eval (let->combination exp) env))
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

**GOOD**

; other solution
; Clever to extract vars / exps

; ((let? expr) (evaln (let->combination expr) env)) 

 ;; let expression 
 (define (let? expr) (tagged-list? expr 'let))
 (define (let-vars expr) (map car (cadr expr)))
 (define (let-inits expr) (map cadr (cadr expr)))
 (define (let-body expr) (cddr expr))

 (define (let->combination expr) 
   (cons (make-lambda (let-vars expr) (let-body expr)) 
         (let-inits expr))) 
