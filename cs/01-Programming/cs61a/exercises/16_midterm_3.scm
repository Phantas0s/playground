; Problem 1

1. 

(let ((x (list 1 2 3)))
  (set-car! x (list ’a ’b ’c))
  (set-car! (cdar x) ’d)
  x)

; (('a 'b 'c) 'd 3) **WRONG** 0/2

;SOLUTION

; (let ((x (list 1 2 3)))
;    (set-car! x (list 'a 'b 'c))
;    (set-car! (cdar x) 'd)
;    x)

; ((a d c) 2 3) is printed.

; X-->[o|o]-->[o|o]-->[o|/]
;      |       |       |      
;      |       V       V
;      |       2       3      
;      V      
;     (o|o)-->{o|o}-->[o|/]
;      |       |       |      
;      V       V       V      
;      a       d       c 

2. 

(define x 3)
(define m (list x 4 5))
(set! x 6)
m

; (3 4 5) **PERFECT** 2/2

; M-->[o|o]-->[o|o]-->[o|/]
;      |       |       |      
;      V       V       V      
;      3       4       5

3.

(define x (list 1 ’(2 3) 4))
(define y (cdr x))
(set-car! y 5)
x

; (1 (5 3) 4) **WRONG** 0/2

; SOLUTION: 
;               Y
;               |
;               |
;               V
; X-->[o|o]-->[o|o]-->[o|/]
;      |       |       |      
;      V       V       V      
;      1       5       4

; In this example, Y names the same pair as (cdr x).  So changing the car of Y
; changes the cadr of X, replacing (2 3) with 5.

4.

; (let ((x (list 1 2 3)))
; (set-cdr! (cdr x) x)
; x)

; (1) **WRONG** 0/2

; SOLUTION

; (1 2 1 2 1 2 1 2 ...    is printed.

;      +---------+
;      |         |
;      V         |
; X-->[o|o]-->[o|o]
;      |       |      
;      V       V      
;      1       2

; This example creates a circular list.

; TOTAL: 02/08

; Problem 2

; Suppose we want to write a procedure prev that takes as its argument a procedure proc
; of one argument. Prev returns a new procedure that returns the value returned by the
; previous call to proc. The new procedure should return #f the first time it is called. For
; example:

; > (define slow-square (prev square))
; > (slow-square 3)
; #f
; > (slow-square 4)
; 9
; > (slow-square 5)
; 16

Which of the following definitions implements prev correctly? Pick only one.

(define (prev proc)
  (let ((old-result #f))
    (lambda (x)
      (let ((return-value old-result))
        (set! old-result (proc x))
        return-value))))

(define prev
  (let ((old-result #f))
    (lambda (proc)
      (lambda (x)
        (let ((return-value old-result))
          (set! old-result (proc x))
          return-value)))))

(define (prev proc)
  (lambda (x)
    (let ((old-result #f))
      (let ((return-value old-result))
        (set! old-result (proc x))
        return-value))))

(define (prev)
  (let ((old-result #f))
    (lambda (proc)
      (lambda (x)
        (let ((return-value old-result))
          (set! old-result (proc x))
          return-value)))))

; 2nd and third one would work, since we would need to call two lambdas after defining slow square.
; 3rd one won't work and always return #f
; First one 

**PERFECT**

; TOTAL: 4/4

; Problem 3

See paper sheet

**WRONG**

; Didn't read well enough...
; TOTAL: 0 / 3

; Problem 4

(define (make-alist! l)
  (set-car! l (cons (car l) (cadr l)))
  (if (empty? (cddr l))
    l
    (make-alist! (cdr l))))

**WRONG**

; TOTAL: 2/4

; Problem 5

; Suppose there are N students taking a midterm. Suppose we have a vector of size N,
; and each element of the vector represents one student’s score on the midterm. Write a
; procedure (histogram scores) that takes this vector of midterm scores and computes
; a histogram vector. That is, the resulting vector should be of size M+1, where M is the
; maximum score on the midterm (it’s M+1 because scores of zero are possible), and element
; number I of the resulting vector is the number of students who got score I on the midterm.

; For example:
; > (histogram (vector 3 2 2 3 2))
; #(0 0 3 2) ;; no students got 0 points, no students got 1 point,

; ;; 3 students got 2 points, and 2 students got 3 points.
; > (histogram (vector 0 1 0 2))
; #(2 1 1) ;; 2 students got 0 points, 1 student got 1 point,

; ;; and 1 student got 2 points.
; Do not use list->vector or vector->list.
; Note: You may assume that you have a procedure vector-max that takes a vector of
; numbers as argument, and returns the largest number in the vector.

(define (histogram vec)
  (define (loop v n max)
    (if (= n max)
      v
      (let ((index (vector-ref vec n))) 
        (begin (vector-set! v index (inc (vector-ref v index)))
               (loop v (+ 1 n) max)))))
  (loop (make-vector (+ (max-vector vec) 1)) 0 (vector-length vec)))

**PERFECT**

; TOTAL: 7/7

; Problem 6

; Choose the answer which best describes each of the following:

; (a) You and a friend decide to have lunch at a rather popular Berkeley resturant. Since
; there is a long line at the service counter, each group of people entering the restaurant
; decide to have someone grab a table while someone else waits in the line to order the food.
; This sounds like a good idea, so your friend sits down at the last free table while you get in
; line. Unfortunately, the resturant stops taking orders when there are no tables available,
; and you have to wait in line for the people ahead of you. This is an example of

; incorrect answer
; deadlock
; inefficency (too much serialization)
; unfairness
; none of the above (correct parallelism)

; (b) After you finally get to eat lunch, you and your friend decide to go to the library to
; work on a joint paper. The library has a policy that students who enter the library must
; open their backpacks to show that they are not bringing food into the library. They have
; several employees doing backpack inspection, so there are several lines for people waiting
; to be inspected. However, today there was a bomb threat, and so the inspectors also use a
; handheld metal detector to examine the backpacks. Although there are several inspectors,
; the library only has one metal detector. This is an example of

; incorrect answer
; deadlock
; inefficency (too much serialization)
; unfairness
; none of the above (correct parallelism)

; (c)While you are working on the paper, your friend decides to do some research for your
; paper and leaves for a few hours while you continue writing. This is an example of

; incorrect answer
; deadlock
; inefficency (too much serialization)
; unfairness
; none of the above (correct parallelism)


a. Deadlock **PERFECT**
b. inefficency (too much serialization) **PERFECT**
c. none of the above (correct parallelism) **PERFECT**

; TOTAL: 3/3

; Problem 7 (Streams).

(define (random-choice a b)
  (if (zero? (random 2)) a b))

(define over 'OVER)
(define under 'UNDER)
(define pattern (cons-stream (list (random-choice over under)) (lambda () ((random-choice over under)))))

; TOTAL: 1/3 (good try :D)

; SOLUTION

; (define foo
;   (cons-stream '()
;                (interleave (stream-map (lambda (p) (cons 'over p)) foo)
;                            (stream-map (lambda (p) (cons 'under p)) foo))))

; GRAND TOTAL: 20/30

; PASSED!

