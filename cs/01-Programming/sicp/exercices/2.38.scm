; The accumulate procedure is also known as
; fold-right, because it combines the first element of the se-
; quence with the result of combining all the elements to the
; right. There is also a fold-left, which is similar to fold-
; right, except that it combines elements working in the op-
; posite direction:

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

; What are the values of

(fold-right / 1 (list 1 2 3)) 
; (/ 1 (/ 2 (/ 3 1))) 
; (/ 1 (/ 2 3))
; (* 1 (/ 3 2))
; 3/2
**PERFECT**

(fold-left / 1 (list 1 2 3))
; (iter ((/ 1 1) (2 3)))
; (iter ((/ 1 2) (3)))
; (iter ((/ (/ 1 2) 3) '()))
; (* (/ 1 2) (/ 1 3))
; 1/6
**PERFECT**

(fold-right list '() (list 1 2 3))
; (list 1 (list 2 (list 3 1)))
; (1 (2 (3 ())))
**PERFECT**

(fold-left list '() (list 1 2 3))
; (3 (2 (1 ())))
**WRONG**

; Give a property that op should satisfy to guarantee that
; fold-right and fold-left will produce the same values
; for any sequence.

; The order of arguments for op should not matter. For example, + will produce the same result whatever the order of its arguments.

**GOOD**

;precision: an operation where you can change the order of argument and which product the same result is called operation commutative.
; Associativity could be required as well; that is, the fact that you can group (with parenthesis) the arguments as you which. Both multiplications and additions are associative and comutative
