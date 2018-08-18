(define (square x) (* x x))
(define (add-square x y)(+ (square x)(square y)))
(define (lns a b c)
  (cond 
    ((and (> a c)(> b c)) (add-square a b))
    ((and (> a b)(> c b)) (add-square a c))
    ((and (> c b)(> b a)) (add-square c b))
    ((and (> c a)(> c b)) (add-square a b))
    ((and (> b a)(> b c)) (add-square a c))
    ((and (> b c)(> a b)) (add-square c b))
    ((and (> c a)(> b c)) (add-square a b))
    ((and (> b a)(> c b)) (add-square a c))
    ((and (> b c)(> b a)) (add-square c b))
    ((and (> a c)(= a b)) (add-square a b))
    ((and (> b a)(= b c)) (add-square b c))
    ((and (= c b)(= c a)) (add-square a c))))

; doesn't work in case (lns 3 2 2)
; better solution
; (define (square x) (* x x)) 
; (define (sumsquares x y) (+ (square x) (square y))) 
; (define (sqsumlargest a b c) 
;   (cond  
;       ((and (>= a c) (>= b c)) (sumsquares a b)) 
;       ((and (>= b a) (>= c a)) (sumsquares b c)) 
;       ((and (>= a b) (>= c b)) (sumsquares a c)))) 
; 

; result 0/1
