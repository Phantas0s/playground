; +-----------+
; | Problem 1 |
; +-----------+

; What will Scheme print in response to the following expressions? If an expression produces
; an error message, you may just say “error”; you don’t have to provide the exact text of
; the message. If the value of an expression is a procedure, just say “procedure”; you don’t
; have to show the form in which Scheme prints procedures.

(every - (keep number? ’(the 1 after 909)))
; -910

**WRONG**

((lambda (a b) ((if (< b a) + *) b a)) 4 6)
; 10

**WRONG**

(word (first ’(cat)) (butlast ’dog))

; cdo

**WRONG**

(cons (list 1 2) (cons 3 4))

; ((1 2) 3 . 4)

**WRONG**

(let ((p (list 4 5)))
  (cons (cdr p) (cddr p)))

; ((5))

**WRONG**

; (cadadr '((a (b) c) (d (e) f) (g (h) i))

**GOOD**

; error - there is one parent missing!!

; +-------------------------------+
; | Problem 2 (Orders of growth). |
; +-------------------------------+


; (a) Indicate the order of growth in time of foo below:
(define (foo n)
  (if (< n 2)
    1
    (+ (baz (- n 1))
       (baz (- n 2)))))
(define (baz n)
  (+ n (- n 1)) )

; Θ(n)

**WRONG**

; (b) Indicate the order of growth in time of garply below:
(define (garply n)
  (if (= n 0)
    0
    (+ (factorial n) (garply (- n 1)))))
(define (factorial n)
  (if (= n 0)
    1
    (* n (factorial (- n 1)))))

; Θ(n^2)

**PERFECT**

; +-------------------------------------------+
; | Problem 3 (Normal and applicative order). |
; +-------------------------------------------+

; Imagine that there is a primitive procedure called counter, with no arguments, that
; returns 1 the first time you call it, 2 the second time, and so on. (The multiplication
; procedure *, used below, is also primitive.)
; Supposing that counter hasn’t been called until now, what is the value of the expression

(* (counter) (counter))

; under applicative order? 2
; under normal order? 1

**WRONG**

; +------------------------------------------------+
; | Problem 4 (Iterative and recursive processes). |
; +------------------------------------------------+

; One or more of the following procedures generates an iterative process. Circle them. Don’t
; circle the ones that generate a recursive process.

(define (butfirst-n num stuff)
  (if (= num 0)
    stuff
    (butfirst-n (- num 1) (bf stuff))))
; iterative process

**PERFECT**

(define (member? thing stuff)
  (cond ((empty? stuff) #f)
        ((equal? thing (first stuff)) #t)
        (else (member? thing (bf stuff)))))
; iterative process

**PERECT**

(define (addup nums)
  (if (empty? nums)
    0
    (+ (first nums)
       (addup (bf nums)))))
; recursive process

**PERFECT**


; +-----------------------------------+
; | Problem 5 (Recursive procedures). |
; +-----------------------------------+

(define (syllables w)
  (define (count-syllables w count)
    (if (empty? w)
      count
      (cond ((vowel? (first w)) (count-syllables (bf w) (+ count 1)))
            (else (count-syllables (bf w) count)))))
  (count-syllables w 0))


(define (vowel? letter)
  (member? letter ’(a e i o u)))

; **WRONG**  - didn't read the problem properly :'(

; +-------------------------------------+
; | Problem 6 (Higher order functions). |
; +-------------------------------------+
; (Part a) Write a procedure in-order? that takes two arguments: first, a predicate function
; of two arguments that returns #t if its first argument comes before its second; second, a
; sentence. Your procedure should return #t if the sentence is in increasing order according
; to the given predicate. Examples:

; > (define (shorter? a b)
; (< (count a) (count b)) )
; > (in-order? shorter? ’(i saw them standing together))
; #t
; > (in-order? shorter? ’(i saw her standing there))
; #f
; > (in-order? < ’(2 3 5 5 8 13))
; #f
; > (in-order? <= ’(2 3 5 5 8 13))
; #t
; > (in-order? > ’(23 14 7 5 2))
; #t

(define (shorter? a b)
  (< (count a) (count b)) )

(define (in-order? pred s)
  (if (empty? s)
    #t
    (cond ((pred (first s) (second s)) (in-order? pred (bf s)))
          (else #f))))

**WRONG**

; (Part b) Write a procedure order-checker that takes as its only argument a predicate
; function of two arguments. Your procedure should return a predicate function with one ar-
; gument, a sentence; this returned procedure should return #t if the sentence is in ascending
; order according to the predicate argument. For example:

; > (define length-ordered? (order-checker shorter?))
; > (length-ordered? ’(i saw them standing together))
; #t
; > (length-ordered? ’(i saw her standing there))
; #f
; > ((order-checker <) ’(2 3 5 5 8 13))
; #f
; > ((order-checker <=) ’(2 3 5 5 8 13))
; #t
; > ((order-checker >) ’(23 14 7 5 2))
; #t

(define (order-checker pred)
  (lambda (s) (in-order? pred s)))

**PERFECT**

; Problem 7 (Data abstraction).
; We want to write a program that uses the time of day as an abstract data type. We’ll
; represent times internally as a list of three elements, such as (11 23 am) for 11:23 am. For
; the purposes of this problem, assume that the hour part is never 12, so there’s never any
; special problems about noon and midnight. The hour will be a number 1–11, the minute
; will be a number 0–59, and the third element (which we’ll call the category) must be the
; word am or the word pm. Here’s our implementation:

; (define
;  (make-time hr mn cat) (list hr mn cat))
; (define
;  hour car)
; (define
;  minute cadr)
; (define
;  category caddr)

; (a) This is a good internal representation, but not a good representation for the user of
; our program to see. Write a function time-print-form that takes a time as its argument
; and returns a word of the form 3:07pm.

; (b) If we want to ask whether one time is before or after another, it’s convenient to use the
; 24-hour representation in which 3:47 pm has the form 1547. Write a procedure 24-hour
; that takes a time as its argument and returns the number that represents that time in
; 24-hour notation:
; > (24-hour (make-time 3 47 ’pm))
; 1547
; Respect the data abstraction!

; (c) Now we decide to change the internal representation of times to be a number in 24-
; hour form. But we want the constructor and selectors to have the same interface so that
; programs using the abstract data type don’t have to change. Rewrite the constructor and
; selectors to accomplish this.

; (a)
(define
  (make-time hr mn cat) (list hr mn cat))
(define
  hour car)
(define
  minute cadr)
(define
  category caddr)

(define (time-print-form time)
  (word (hour time) ': (minute time) (category time)))

**GOOD**

; (b)

(define (24-hour time)
  (if (equal? (category time) 'pm)
    (+ (* (+ 12 (hour time)) 100) (minute time))
    (+ (* (hour time) 100) (minute time))))

**PERFECT**

; (c) 

(define (make-time hr mn cat) 
  (if (equal? cat 'pm)
    (list (+ 12) mn cat)
    (list hr mn cat)))
(define hour car)
(define minute cadr)
(define category caddr)
