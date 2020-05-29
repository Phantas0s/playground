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
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                          kinds-of-coins))
                     kinds-of-coins)))))

(define (new-count-change amount) (cc amount 5))
(define (new-cc amount kinds-of-coins)
  (cond ((or (< amount 0) (= kinds-of-coins 0)) 0)
        ((= amount 0) 1)
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


; The value would be different with (cc 0 0) - for the case in the book, it returns 1, and for the new-cc, it returns 0.

; +------------+
; | Exercise 4 |
; +------------+
(define (expt b n)
  (if (= n 0)
    1
    (* b (expt b (- n 1)))))

(define (expt-i b n)
  (expt-iter b n 1))
(define (expt-iter b counter product)
  (if (= counter 0)
    product
    (expt-iter b
               (- counter 1)
               (* b product))))

; Give An Algebraic Formula Relating The Values Of The Parameters B, N, Counter, And
; Product Of The Expt And Exp-iter Procedures Given Near The Top Of Page 45 Of Abelson
; And Sussman. (The Kind Of Answer We’Re Looking For Is “The Sum Of B, N, And Counter Times
; Product Is Always Equal To 37.”)

;b power counter by product is always equals to b power counter

