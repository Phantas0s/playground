; +--------+
; | Part 1 |
; +--------+

(define (cont-frac n d k)
           (if (= k 0)
             0
           (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

; need k = 11 to have an accurate 4 decimal places answer
(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)
; => 0.6180555555555556

**GOOD**

; +--------+
; | Part 2 |
; +--------+

(define (cont-frac-iter n d k)
  (define (ct n d k t)
           (if (= k 0)
            (- t 1)
           (ct n d (- k 1) (+ (d k) (/ (n k) t)))))
  (ct n d k (/ (n k) (+ (d k) (d k)))))

**GOOD**
