; +---------------+
; |  EXERCISE 1.1 |
; +---------------+

; 10
10
; (+ 5 3 4)
12
; (- 9 1)
8
; (/ 6 2)
3
; (+ (* 2 4) (- 4 6))
6
; (define a 3)
; (define b (+ a 1))
; (+ a b (* a b))
19
; (= a b)
#f
; (if (and (> b a) (< b (* a b)))
; b
; a)
4
; (cond ((= a 4) 6)
; ((= b 4) (+ 6 7 a))
; (else 25))
16
; (+ 2 (if (> b a) b a))
6
; (* (cond ((> a b) a)
; ((< a b) b)
; (else -1))
; (+ a 1))
16

; **PERFECT**

; +---------------+
; |  EXERCISE 1.2 |
; +---------------+


(/ 
  (+ (+ 5 4)
     (- 2 (- 3 (+ 6 (/ 4 5))))) 
  (* 3 
     (- 6 2) 
     (- 2 7)))

; **PERFECT**

; +--------------+
; | EXERCISE 1.3 |
; +--------------+

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
; **WRONG**

; +--------------+
; | EXERCISE 1.4 |
; +--------------+

(define (a-plus-abs-b a b)
((if (> b 0) + -) a b))

; if b > 0, the return will be (+ a b), otherwise (- a -b) equivalent to (+ a b)

; **GOOD**

; +--------------+
; | EXERCISE 1.5 |
; +--------------+

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

; Normal order
; Everything is expended
; (test 0 (p))
; (if (= x 0) 0 (p))
; 0

; Applicative order
; (test 0 (p))
; p is infinetely expended to itself and the program never terminate

; **PERFECT**

; +---------------+
; |  EXERCISE 1.6 |
; +---------------+

; With this new form of if, the consequent and alternative will be evaluated as well as the predicate.
; Since the alternative has a recursion the program will never stop

; **PERFECT**

; ======= solution found on internet

; The default if statement is a special form which means that even when an interpreter follows applicative substitution, it only evaluates one of it's parameters- not both. However, the newly created new-if doesn't have this property and hence, it never stops calling itself due to the third parameter passed to it in sqrt-iter. 

; +---------------+
; |  EXERCISE 1.7 |
; +---------------+

;
; √x = the y such that y ≥ 0 and y 2 = x.
;

(define (square x)(* x x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
(sqrt-iter 1.0 x))

; For small number like 0,00001 the absolute tolerance of 0.001 is too large. For large number like 10000000000000000000000000000000 the tolerance is too small resulting in an infinite of iteration because of the recursion...

(define (square x)(* x x))

(define (sqrt-iter old guess x)
  (if (good-enough? old guess x)
    guess
    (sqrt-iter guess (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? old guess x)
  (< (abs(- guess old)) 0.000000001))

(define (sqrt x)
(sqrt-iter 10.0 1.0 x))

**GOOD**

; +---------------+
; | Exercise 1.08 |
; +---------------+

;square cube
;(x/(y*y) + 2y) / 3
;

(define (square x)(* x x))
(define (cube x)(* x x x))

(define (sqrt-iter old guess x)
  (if (good-enough? old guess x)
    guess
    (sqrt-iter guess (average guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average y x)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

(define (good-enough? old guess x)
  (< (abs(- guess old)) 0.000000001))

(define (sqrt x)
(sqrt-iter 0 1.0 x))

; +---------------+
; | Exercise 1.09 |
; +---------------+

(define (+ a b)
  (if (= a 0) b (inc (+ (dec a) b))))

; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc (5)))))
; (inc (inc (inc (6))))
; (inc (inc (7)))
; (inc (8))
; 9

; => linear recursive process

(define (+ a b)
  (if (= a 0) b (+ (dec a) (inc b))))

; (+ 4 5)
; (+ 3 6)
; (+ 2 7)
; (+ 1 8)
; (+ 0 9)
; 9

; => linear iterative process

; +---------------+
; | Exercise 1.10 |
; +---------------+

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

; (A 1 10); 
; (A (- 1 1) (A 1 9))
; (A (- 1 1) (A (- 1 1) (A 1 8)))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 7))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 6)))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 5))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 4)))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 3))))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 2))))))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 1))))))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 0 2)))))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) 4))))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 0 4))))))))
; (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) 8)))))))
; 1024
; 2^10

; (A 2 4)
; (A (- 2 1) (A 2 3))
; (A (- 2 1) (A (- 2 1) (A 2 2)))
; (A (- 2 1) (A (- 2 1) (A (- 2 1) (A 2 1)))
; (A (- 2 1) (A (- 2 1) (A (- 2 1) 2)))
; (A (- 2 1) (A (- 2 1) (A 1 2)))
; (A (- 2 1) (A (- 2 1) (A (-1 1) (A 1 1)))
; (A (- 2 1) (A (- 2 1) (A 0 2)))
; (A (- 2 1) (A (- 2 1) 4))
; (A (- 2 1) (A 1 4))
; (A (- 2 1) (A (- 1 1) (A 1 3)))
; (A (- 2 1) (A (- 1 1) (A (- 1 1) (A 1 2))))
; (A (- 2 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 1))))
; (A (- 2 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) (A 1 1))))
; (A (- 2 1) (A (- 1 1) (A (- 1 1) (A (- 1 1) 2)))
; (A (- 2 1) (A (- 1 1) (A (- 1 1) 4))
; (A (- 2 1) (A (- 1 1) 8))
; (A (- 2 1) 16))
; (A 1 16))
; 2^2^2^2

; (A 3 3)
;(A (-3 1) (A 3 2))
;(A (-3 1) (A (-3 1) (A 3 1)))
;(A (-3 1) (A (-3 1) 2))
;(A (-3 1) (A 2 2))
;(A (-3 1) (A (-2 1) (A 2 1)))
;(A (-3 1) (A (-2 1) 2))
;(A (-3 1) (A (-3 1) (A (- 2 1) (-2 1))))
;(A (-3 1) (A (-3 1) (A (-3 1) (A 1 1)))
;(A (-3 1) (A (-3 1) (A 2 2)))
;(A (-3 1) (A (-3 1) (A (- 2 1) (A 2 1)))))
;(A (-3 1) (A (-3 1) (A 1 2)))
;(A (-3 1) (A (-3 1) (A -(1 1) (A 1 (-2 1)))))
;(A (-3 1) (A (-3 1) (A -(1 1) (A 1 1)))))
;(A (-3 1) (A (-3 1) (A 0 2))))
;(A (-3 1) (A (-3 1) 4)))
;(A (-3 1) (A 2 4)))
;(A 2 (A 2 4)))
;(A 2 (A (-2 1) (A 2 3)))
;(A 2 (A (-2 1) (A (-2 1) (A 2 2))))
;(A 2 (A (-2 1) (A (-2 1) (A (-2 1) (A 2 1)))))
;(A 2 (A (-2 1) (A (-2 1) (A (-2 1) 2))))
;(A 2 (A (-2 1) (A (-2 1) (A 1 2))))
;(A 2 (A (-2 1) (A (-2 1) (A (- 1 1) (A 1 1)))))
;(A 2 (A (-2 1) (A (-2 1) (A (- 1 1) 2))))
;(A 2 (A (-2 1) (A (-2 1) 4)))
;(A 2 (A (-2 1) (A 3 4)))
;(A 2 (A (-2 1) (A (-3 1) (A 3 4))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) A(3 2)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) (A (-3 1) (A 3 1))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) (A (-3 1) 2)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) (A 2 2)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) (A (-2 1) (A 2 1))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) (A 1 2)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-3 1) 4))))
;(A 2 (A (-2 1) (A (-3 1) (A 2 4))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A 2 3)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) (A 2 2))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) (A (- 2 1) (A 2 1)))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) (A (- 2 1) 2))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) (A 1 2))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) (A (- 1 1) (A 1 1))))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) (A 0 2)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (-2 1) 4)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A 1 4)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A 1 3)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A (-1 1) (A 1 2)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A (-1 1) (A (-1 1) (A 1 1)))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A (-1 1) (A (-1 1) 2))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A (-1 1) (A 0 2))))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A (-1 1) 4)))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) (A 0 4)))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) (A (- 1 1) 8))
;(A 2 (A (-2 1) (A (-3 1) (A (-2 1) 16))
;(A 2 (A (-2 1) (A (-3 1) (A 1 16))
;(A 2 (A (-2 1) (A (-3 1) (A 1 16))
;...

; 2^2^2^2


; (define (f n) (A 0 n))
; (define (f n) (* 2 n))

(define (g n) (A 1 n))
(define (f n) (expt 2 n))

(define (h n) (A 2 n))
; (define (h n) (expt 2 (expt 2) ... n times)

**GOOD**

; +---------------+
; | Exercise 1.11 |
; +---------------+


; recursive
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

; iterative
(define (fib n)
  (fib-iter 1 0 n))
(define (fib-iter a b count)
  (if (= count 0)
    b
    (fib-iter (+ a b) a (- count 1))))

; f (n) =
; n if n < 3,
; f (n − 1) + 2f (n − 2) + 3f (n − 3) if n ≥ 3.
(define (tree-rec n)
  (if (< n 3)
    n
    (+ (tree-rec (- n 1))
       (* 2 (tree-rec (- n 2)))
       (* 3 (tree-rec (- n 3))))))


(define (tree n)
  (tree-iter 0 1 2 n))

; Didn't come up with this solution no clue about maths :'(
; Did find the tree procedure arguments, the count -1 and the fact that somehow something had to be done :D
(define (tree-iter a b c count)
  (if (= count 0)
    a
    (fib-iter b c (+ c (* 2 b) (* 3 a)) (count - 1))))

; +---------------+
; | Exercise 1.12 |
; +---------------+

(define (pas row col)
  (cond((= col 0) 1)
        ((= col row ) 1)
        (else (+ (pas (- row 1) (- col 1)) (pas (- row 1) col)))))


; +---------------+
; | Exercise 1.13 |
; +---------------+

**SKIPPED**

; +---------------+
; | Exercise 1.14 |
; +---------------+

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
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 11)
; Steps exponential 
; space linear (depth of the tree o(n))

; +---------------+
; | Exercise 1.15 |
; +---------------+

; 12,5
;  |
; 4,16
;  |
; 1,38
;  |
; 0,4
;  |
; 0,15
;  |
; 0.05

;a - 5 call of p

; the order of growth is θ=log(a)
; we keep dividing by 3 N, so it will take log(a) time to reach the solution. 

; log(12.5) is roughly equal to 2*2*2*2 (+1 for the first iteration) -> 5 iterations

; +---------------+
; | Exercise 1.16 |
; +---------------+

(define (square x) (* x x))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (expt-iter b n) (fast-expt-iter 1 b n))
(define (fast-expt-iter a b n)
  (cond ((= n 0) b)
  ((even? n) (fast-expt-iter a (square b) (/ n 2)))
  (else (fast-expt-iter (* a b) b (- n 1)))))



; (Hint: Using the observation that (b n/2 ) 2 = (b 2 ) n/2 , keep,
; along with the exponent n and the base b, an additional
; state variablea, and define the state transformation in such
; awaythattheproductab n isunchangedfromstatetostate.
; At the beginning of the process a is taken to be 1, and the
; answer is given by the value of a at the end of the process.
; In general, the technique of defining an invariant quantity
; that remains unchanged from state to state is a powerful
; way to think about the design of iterative algorithms.)

; 1 2 3
; 2 2 2
; 2 4 1
; => 8

; 1 2 7
; 2 2 6
; 2 4 3
; 8 4 2
; 8 16 1
; => 128

; +---------------+
; | Exercise 1.17 |
; +---------------+

(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

(define (double a) (+ a a))
(define (halve a) (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (* a b)
  (cond ((= b 0) 0)
    ((even? b) (double (* a (halve b))))
    (else (double (* a (- b 1))))))

; (3 4)
; (double (3 2))
; (double (double (3 1)))
; (double (double (+ 3 1)))
; (double (double 3))
; (double 6)
; 12

; +---------------+
; | Exercise 1.18 |
; +---------------+

(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

(define (double a) (+ a a))
(define (halve a) (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (* a b) (multiply 0 a b))
(define (multiply z a b)
  (cond ((= b 0) z)
    ((even? b) (multiply z (double a) (halve b)))
    (else (multiply (+ z a) a (- b 1)))))

; (0 3 4)
; (multiply 0 6 2)
; (multiply 0 12 1)
; (multiply 12 12 0)
; 12

; (0 4 5)
; (multiply 4 4 4)
; (multiply 4 8 2)
; (multiply 4 16 1)
; (multiply 20 16 0)
; 20

; +---------------+
; | Exercise 1.19 |
; +---------------+

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

; Spend a long time on this... the struggle is real :D 
; Impossible to find without a minimum of mathematic knowledge

**SKIPPED****


