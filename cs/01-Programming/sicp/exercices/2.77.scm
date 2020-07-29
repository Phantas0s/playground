; Exercise 2.77: Louis Reasoner tries to evaluate the expres-
; sion (magnitude z) where z is the object shown in Figure
; 2.24. To his surprise, instead of the answer 5 he gets an error
; message from apply-generic, saying there is no method
; for the operation magnitude on the types (complex). He
; shows this interaction to Alyssa P. Hacker, who says “The
; problem is that the complex-number selectors were never
; defined for complex numbers, just for polar and rectangular
; numbers. All you have to do to make this work is add the
; following to the complex package:”

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

; Describe in detail why this works. As an example, trace
; through all the procedures called in evaluating the expres-
; sion (magnitude z) where z is the object shown in Figure
; 2.24. In particular, how many times is apply-generic in-
; voked? What procedure is dispatched to in each case?

; Let's bring back some code here

(define (real-part z) (apply-generic 'real-part z))

(define (imag-part z) (apply-generic 'imag-part z))

(define (magnitude z) (apply-generic 'magnitude z))

(define (angle z) (apply-generic 'angle z))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
    (car datum)
    (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
    (cdr datum)
    (error "Bad tagged datum: CONTENTS" datum)))

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z) (eq? (type-tag z) 'polar))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error
          "No method for these types: APPLY-GENERIC"
          (list op type-tags))))))

; 0. First invocation of apply-generic
; 1. type-tags = complex
; 2. proc = magnitude
; 3. apply magnitude to cdr of z (rectangular number)
; 4. Second invocation of apply-generic
; 5. type-tags = rectangular
; 6. proc = magnitude
; 7. apply magnitude to z
; 8. return 5

**GOOD**
