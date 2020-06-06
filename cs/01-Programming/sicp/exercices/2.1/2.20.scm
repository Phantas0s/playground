(define (same-parity x . l)
  (define (remove-other-parity x l new-list)
    (if (empty? l)
      new-list
      (cond ((or (and (odd? x) (odd? (car l))) 
               (and (even? x) (even? (car l)))) 
             (remove-other-parity x (cdr l) (append new-list (list (car l)))))
            (else (remove-other-parity x (cdr l) new-list)))))
  (cons x (remove-other-parity x l '())))

**GOOD**
