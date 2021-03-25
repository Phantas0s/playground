; Scheme allows us to create new bindings for
; variables by means of define, but provides no way to get
; rid of bindings. Implement for the evaluator a special form
; make-unbound! that removes the binding of a given symbol
; from the environment in which the make-unbound! expres-
; sion is evaluated. This problem is not completely specified.
; For example, should we remove only the binding in the first
; frame of the environment? Complete the specification and
; justify any choices you make.

(define (make-unbound! exp env)
 (let ((frame (first-frame env))
        (frame-vars (frame-variables frame))
        (fram-vals (frame-values frame)))
        (set-car! frame-vars (cadr frame-vars))
        (set-car! frame-vals (cadr frame-vals))
    ))

;; WRONG
;; Needs to do a search for the element...

;; SOLUTION

;;there's no need to unbound bindings in the enclosing environments,and no need to send an error message(just like "define"),a simpler version is: 
 (define (make-unbound! var env) 
   (let* ((frame (first-frame env)) 
          (vars (frame-variables frame)) 
          (vals (frame-values frame))) 
     (define (scan pre-vars pre-vals vars vals) 
       (if (not (null? vars)) 
           (if (eq? var (car vars)) 
               (begin (set-cdr! pre-vars (cdr vars)) 
                      (set-cdr! pre-vals (cdr vals))) 
               (scan vars vals (cdr vars) (cdr vals))))) 
     (if (not (null? vars)) 
         (if (eq? var (car vars)) 
             (begin (set-car! frame (cdr vars)) 
                    (set-cdr! frame (cdr vals))) 
             (scan vars vals (cdr vars) (cdr vals)))))) 
