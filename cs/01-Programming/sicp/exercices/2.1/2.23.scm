; +---------------+
; | Exercise 2.23 |
; +---------------+

(define (for-each p l)
  (cond ((empty? l) true)
        ((not (empty? l)) (p (car l)) (for-each p (cdr l)))))

**PERFECT**
