; +------------+
; | Exercise 2 |
; +------------+

(define (factor? n b)
  (if (= (modulo n b) 0)
    true
    false))

(define (next-perf n)
  (define (sum-of-factors current n)
    (cond ((= n 0) 0)
          ((factor? current n) (+ n (sum-of-factors current (- n 1))))
          (else (+ 0 (sum-of-factors current (- n 1))))))
  (if (= (sum-of-factors n (- n 1)) n)
    n
    (next-perf (+ n 1))))

**PERFECT**

; +------------+
; | Exercise 3 |
; +------------+

; (define (cc amount kinds-of-coins)
; (cond
; ((or (< amount 0) (= kinds-of-coins 0)) 0)
; ((= amount 0) 1)
; (else ... ) ) )
;  ; as in the original version

(define (count-change amount) (cc amount 5))
(define ((= amount 0) 1)
  (cond (cc amount kinds-of-coins)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                          kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

If we change the two first condition branches, 
