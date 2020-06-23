; +---------------+
; | Exercise 2.29 |
; +---------------+

; A binary mobile consists of two branches,
; a left branch and a right branch. Each branch is a rod of
; a certain length, from which hangs either a weight or an-
; other binary mobile. We can represent a binary mobile us-
; ing compound data by constructing it from two branches
; (for example, using list):

(define (make-mobile left right)
  (cons left right))

; A branch is constructed from a length (which must be a
; number) together with a structure, which may be either a
; number (representing a simple weight) or another mobile:

(define (make-branch length structure)
  (cons length structure))

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

(define (last-mobile? mobile)
  (and (weight? (branch-structure (left-branch mobile))) (weight? (branch-structure (right-branch mobile)))))

(define (current-mobile-balanced? mobile)
  (let ((left-struct (branch-structure (left-branch mobile)))
        (right-struct (branch-structure (right-branch mobile)))
        (left-length (branch-length (left-branch mobile)))
        (right-length (branch-length (right-branch mobile))))
    (if (last-mobile? mobile)
      (= (* left-struct left-length) (* right-struct right-length))
      (= (* left-length (cond ((weight? left-struct) left-struct)
                              ((mobile? left-struct) (total-weight left-struct))))
         (* right-length (cond ((weight? right-struct) right-struct)
                               ((mobile? right-struct) (total-weight right-struct))))))))

(define (balanced? mobile)
  (let ((left-struct (branch-structure (left-branch mobile)))
        (right-struct (branch-structure (right-branch mobile)))
        (left-length (branch-length (left-branch mobile)))
        (right-length (branch-length (right-branch mobile))))
    (if (current-mobile-balanced? mobile)
      (cond ((mobile? left-struct) (balanced? left-struct))
            ((mobile? right-struct) (balanced? right-struct))
            (else true))
      false)))

; TESTS

(define mob-unb (make-mobile 
              (make-branch 1 (make-mobile ; unbalanced
                               (make-branch 1 (make-mobile 
                                                (make-branch 2 1) 
                                                (make-branch 2 1)))
                               (make-branch 1 (make-mobile
                                                (make-branch 1 2)
                                                (make-branch 1 2)))))
              (make-branch 2 (make-mobile
                               (make-branch 1 2) 
                               (make-branch 1 2)))))

(define mob-unb-2 (make-mobile 
              (make-branch 1 (make-mobile
                               (make-branch 1 (make-mobile
                                                (make-branch 1 1)
                                                (make-branch 1 2)))
                               (make-branch 1 (make-mobile
                                                (make-branch 1 1)
                                                (make-branch 1 2)))))
              (make-branch 2 (make-mobile ; unbalanced
                               (make-branch 2 5)
                               (make-branch 1 1)))))

(define mob-unb-3 (make-mobile 
              (make-branch 1 (make-mobile
                               (make-branch 1 (make-mobile
                                                (make-branch 1 2)
                                                (make-branch 1 2)))
                               (make-branch 1 (make-mobile ; unbalanced
                                                (make-branch 1 1)
                                                (make-branch 1 2)))))
              (make-branch 2 (make-mobile
                               (make-branch 1 6)
                               (make-branch 6 1)))))

(define mob-bal (make-mobile 
              (make-branch 1 (make-mobile
                               (make-branch 1 (make-mobile
                                                (make-branch 1 1)
                                                (make-branch 1 1)))
                               (make-branch 1 (make-mobile
                                                (make-branch 1 1)
                                                (make-branch 1 1)))))
              (make-branch 1 (make-mobile
                               (make-branch 1 2)
                               (make-branch 1 2)))))

(define mob-bal-2 (make-mobile 
              (make-branch 1 (make-mobile
                               (make-branch 1 (make-mobile
                                                (make-branch 6 1)
                                                (make-branch 3 2)))
                               (make-branch 1 (make-mobile 
                                                (make-branch 2 2)
                                                (make-branch 4 1)))))
              (make-branch 1 (make-mobile
                               (make-branch 1 5)
                               (make-branch 5 1)))))
(balanced? mob-unb)
(balanced? mob-unb-2)
(balanced? mob-unb-3)
(balanced? mob-bal)
(balanced? mob-bal-2)


;d 

; Here are the changes to make to replace lists by pairs

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define (mobile? structure)
  (pair? structure))
