; Examine the stream (pairs integers integers).
; Can you make any general comments about the order in
; which the pairs are placed into the stream? For example,
; approximately how many pairs precede the pair (1, 100)?
; the pair (99, 100)? the pair (100, 100)? (If you can make pre-
; cise mathematical statements here, all the better. But feelb
; free to give more qualitative answers if you find yourself
; getting bogged down.)

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

; (1, 100)

; If we follow the pattern, there is a pair 1,X every two pairs, thus it would be ~200 pairs before the pair 1,100.

**GOOD** 

; (100,100)

; A new number on the left side (equals to the number of the right side) appears every power of 2 index. Which means that there is ~2^100 to get to (100,100).

**GOOD** 

; (99,100)

; It will take ~99^99 to get to (99,99). For (99,100), ??? 

**WRONG**

; OTHER SOLUTION

; (1,100):198;
; (100,100):2^100 - 1;
; ---------------
; f(n,m) m>=n (m,n is Z+)
; (m-n=0): 2^n - 1
; (m-n=1): (2^n - 1) + 2^(n - 1)
; (m-n>1): (2^n - 1) + 2^(n - 1) + (m - n - 1) * 2^n
; ------------------------------------
;   1   2   3   4   5   6   7   8   9  ...  100   
; 1 1   2   4   6   8  10  12  14  16       198 
; 2     3   5   9  13  17  21  25  29        
; 3         7  11  19  27  35  43  51
; 4            15  23  39  .....
; 5                31  .........
; .
; .
; 100 ------------------------------------- (2^100 - 1)

; in scheme

(define (index-of-pair pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (cond ((> i j) #f)
          ((= i j) (+ (expt 2 i) -1))
          (else (+ (* (expt 2 i) (- j i))
                   (expt 2 (- i 1))
                   -1)))))
