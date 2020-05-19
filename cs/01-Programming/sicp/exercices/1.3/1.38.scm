; e ~= 2.718281828459

(define (cont-frac n d k)
           (if (= k 0)
             0
           (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

; How to find Di???

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)

**SKIPPED 25min**
