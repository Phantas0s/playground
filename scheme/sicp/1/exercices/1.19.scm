; (define (fib n)
;   (fib-iter 1 0 0 1 n))
; (define (fib-iter a b p q count)
;   (cond ((= count 0) b)
;         ((even? count)
;          (fib-iter a
;                    b
;                    ⟨ ?? ⟩ ; compute p ′
;                    ⟨ ?? ⟩ ; compute q ′
;                    (/ count 2)))
;         (else (fib-iter (+ (* b q) (* a q) (* a p))
;                         (+ (* b p) (* a q))
;                         p
;                         q
;                         (- count 1)))))

(define (even? n)
  (= (remainder n 2) 0))

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   p?
                   q?
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

; Spend on long time on this...
; Impossible to find without a minimum of mathematic knowledge
