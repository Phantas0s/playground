(map caddr '((2 3 5) (7 11 13) (17 19)))
; => (5 13)
; **WRONG** 0/2

(list (cons 2 (cons 3 5)))
; => ((2 (3 5)))
; **WRONG** 0/2

(append (list '(2) '(3)) (cons '(4) '(5)))
; => ((2) (3) (4 (5)))
; **WRONG** 0/2

(list (cons '(0) '(1)) (append '(2) '(3)))
; => (((0) 1) (2 3))
**GOOD** ; 2/2

; Problem 2

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define my-tree (make-tree 8 (make-tree 5 '() '())
                           (make-tree 12 '() '())))

(define (all-smaller? tree comp)
  (if (empty? tree)
    #t
    (cond ((> (entry tree) comp) #f)
          ((and (all-smaller? (left-branch tree) comp)
                (all-smaller? (right-branch tree) comp))
           #t)
          (else #f))))

(all-smaller? my-tree 15)
;#T
(all-smaller? my-tree 10)
;#F

(define (all-larger tree comp)
  (if (empty? tree)
    #t
    (cond ((< (entry tree) comp) #f)
          ((and (all-smaller? (left-branch tree) comp)
                (all-smaller? (right-branch tree) comp))
           #t)
          (else #f))))

(define (bst? btree)
  (if (empty? tree)
    #t
    (if (and (all-larger? (right-branch tree) (entry tree))
             (all-smaller? (left-branch tree) (entry tree)))
      (and (bst? (make-tree (entry (left-branch tree)) (left-branch (left-branch tree)) (right-branch (left-branch tree))))
           (bst? (make-tree (entry (right-branch tree)) (left-branch (right-branch tree)) (right-branch (right-branch tree)))))
      #f)))

; **GOOD**
; pretty ugly though
; here are better solutions 5 / 5

(define (all-smaller? tree num)
  (or (null? tree)
      (and (< (entry tree) num)
	   (all-smaller? (left-branch tree) num)
	   (all-smaller? (right-branch tree) num))))

(define (bst? tree)
  (or (null? tree)
      (and (all-smaller? (left-branch tree) (entry tree))
	   (all-larger? (right-branch tree) (entry tree))
	   (bst? (left-branch tree))
	   (bst? (right-branch tree)))))

; Problem 3

(define (max-fanout tree)
  (if (empty? tree)
    0
    (max (append (count children) (max-fanout (cadr children)) (max-fanout (caddr children))))))

; **GOOD**
; Lost points to not have the good abstraction (cadr / caddr instead of using forest)
; better solutions 2/4

(define (max-fanout tree)
  (accumulate max
	      (length (children tree))
	      (map max-fanout (children tree))))

; or 

(define (max-fanout tree)
  (max (length (children tree))
       (max-fanout-forest (children tree))))

(define (max-fanout-forest forest)
  (if (null? forest)
      0
      (max (max-fanout (car forest))
	   (max-fanout-forest (cdr forest)))))


; Problem 4

(define (plus x y)
  (let ((type-x (car x))
        (type-y (car y))
        (val-x (cadr x))
        (val-y (cadr y))
        (x-to-y (get type-x type-y))
        (y-to-x (get type-y type-x)))
    (cond ((equal? type-x type-y) (attach-tag type-x (+ val-x val-y)))
          ((number? x-to-y) (attach-tag type-y (+ (* x-to-y val-x) val-y)))
          ((number? y-to-x) (attach-tag type-x (+ val-x (* y-to-x val-y))))
         (else (error "you can't add apples and oranges")))))

; **GOOD** 
; -2 point to have used car / cadr instead of procedure type and content
; 6 / 8
; Here's another solution


(define (plus x y)
  (let ((tx (type x))
	(ty (type y)))
    (if (eq? tx ty)
	(attach-tag tx (+ (contents x) (contents y)))
	(let ((gxy (get tx ty))
	      (gyx (get ty tx)))
	  (cond ((number? gxy)
		 (attach-tag ty (+ (* gxy (contents x)) (contents y))))
		((number? gyx)
		 (attach-tag tx (+ (contents x) (* gyx (contents y)))))
		(else (error "You can't add apples and oranges.")))))))

; Problem 5 (Object-Oriented Programming)

; A. Neither
; **GOOD** child is a "kind of", not a "part of" 
; 2/2

; B. ask
**WRONG**
; (method (flavors)
;   (map (LAMBDA (S) (ASK S 'FLAVOR)) scoops))
; 0 / 2

; C. (ask my-cone ’add-scoop (instantiate vanilla))
**PERFECT**
;2/2

; TOTAL SCORE

; 19/31
; Can do WAY better!
; Continue your effort dear student
