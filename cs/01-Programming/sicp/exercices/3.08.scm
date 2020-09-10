; When we defined the evaluation model in
; Section 1.1.3, we said that the first step in evaluating an
; expression is to evaluate its subexpressions. But we never
; specified the order in which the subexpressions should be
; evaluated (e.g., left to right or right to left). When we in-
; troduce assignment, the order in which the arguments to a
; procedure are evaluated can make a difference to the result.

; Define a simple procedure f such that evaluating

(+ (f 0) (f 1))

; will return 0 if the arguments to + are evaluated from left to
; right but will return 1 if the arguments are evaluated from
; right to left.

(define pass 0)

(define (f num)
  (set! pass (+ pass 1))
  (if (= pass 1)
    num
    0))

(+ (f 0) (f 1))
; (+ (f 1) (f 0))

(define f  
  (let ((state 0)) 
    (lambda (arg) 
      (begin state (set! state arg))))) 

; **GOOD**

; I use a global var here; but we could use a local one. Something like (even simpler):

(define f 
  (let ((count 1)) 
    (lambda (x)  
      (set! count (* count x)) 
      count))) 
