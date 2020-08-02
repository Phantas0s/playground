; Suppose you are designing a generic arith-
; metic system for dealing with the tower of types shown in
; Figure 2.25: integer, rational, real, complex. For each type
; (except complex), design a procedure that raises objects of
; that type one level in the tower. Show how to install a
; generic raise operation that will work for each type (ex-
; cept complex).

(define (integer->rational int)
  (make-rat int 1))

(define (rat->real rat)
  (make-real (/ (numer rat) (denom rat))))

(define (raise construct base default)
  (construct base default))

**WRONG**

; I forgot to install them in the different packages...

**SOLUTION**

 (define (raise x) (apply-generic 'raise x)) 

 ;; add into scheme-number package 
 (put 'raise 'integer  
          (lambda (x) (make-rational x 1))) 

 ;; add into rational package 
 (put 'raise 'rational 
          (lambda (x) (make-real (/ (numer x) (denom x))))) 

 ;; add into real package 
 (put 'raise 'real 
          (lambda (x) (make-from-real-imag x 0))) 
