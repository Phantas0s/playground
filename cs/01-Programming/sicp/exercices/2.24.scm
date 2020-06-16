; +-----------------+
; |  Exercise 2.24  |
; +-----------------+

; Suppose we evaluate the expression (list 1 (list 2 (list 3 4))).
; Give the result printed by the interpreter, the corresponding box-and-pointer structure,
; and the interpretation of this as a tree (as in Figure 2.6).

; See jpeg file

; +-----------------+
; |  Exercise 2.26  |
; +-----------------+

; Suppose we define x and y to be two lists:
(define x (list 1 2 3))
(define y (list 4 5 6))

; What result is printed by the interpreter in response to eval-
; uating each of the following expressions:

(append x y)
; (1 2 3 4 5 6)
(cons x y)
; ((1 2 3) 4 5 6)
(list x y)
; ((1 2 3) (4 5 6))

**PERFECT**

; A binary mobile consists of two branches,
; a left branch and a right branch. Each branch is a rod of
; a certain length, from which hangs either a weight or an-
; other binary mobile. We can represent a binary mobile us-
; ing compound data by constructing it from two branches
; (for example, using list):

(define (make-mobile left right)
  (list left right))

; A branch is constructed from a length (which must be a
; number) together with a structure, which may be either a
; number (representing a simple weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

; a. Write the corresponding selectors left-branch and
; right-branch, which return the branches of a mobile,
; and branch-length and branch-structure, which re-
; turn the components of a branch.

; b. Using your selectors, define a procedure total-weight
; that returns the total weight of a mobile.

; c. A mobile is said to be balanced if the torque applied by
; its top-le branch is equal to that applied by its top-
; 151
; right branch (that is, if the length of the le rod mul-
; tiplied by the weight hanging from that rod is equal
; to the corresponding product for the right side) and if
; each of the submobiles hanging off its branches is bal-
; anced. Design a predicate that tests whether a binary
; mobile is balanced.

; d. Suppose we change the representation of mobiles so
; that the constructors are
; (define (make-mobile left right) (cons left right))
; (define (make-branch length structure)
; (cons length structure))
; How much do you need to change your programs to
; convert to the new representation?

;a.

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;b.

(define (mobile? structure)
  (list? structure))

(define (weight? structure)
  (number? structure))

(define (total-weight mobile)
  (let ((right (branch-structure (right-branch mobile)))
        (left (branch-structure (left-branch mobile))))
    (+ (+ (cond ((weight? left) left)
                ((mobile? left) (total-weight left))))
       (+ (cond ((weight? right) right)
                ((mobile? right) (total-weight right)))))))

(define mob (make-mobile 
              (make-branch 1 (make-mobile
                               (make-branch 1 (make-mobile
                                                (make-branch 1 1)
                                                (make-branch 1 2)))
                               (make-branch 1 (make-mobile
                                                (make-branch 1 1)
                                                (make-branch 1 (make-mobile
                                                                 (make-branch 1 1)
                                                                 (make-branch 1 2)))))))
              (make-branch 2 (make-mobile
                               (make-branch 2 2)
                               (make-branch 2 1)))))

(total-weight mob)

;total 10

**PERFECT**

;c.


