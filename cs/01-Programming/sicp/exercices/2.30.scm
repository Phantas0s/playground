; Define a procedure square-tree analogous
; to the square-list procedure of Exercise 2.21. That is, square-
; tree should behave as follows:

; (square-tree
;   (list 1
;         (list 2 (list 3 4) 5)
;         (list 6 7)))

; (1 (4 (9 16) 25) (36 49))

; Define square-tree both directly (i.e., without using any
; higher-order procedures) and also by using map and recur-
; sion.

; directly

(define (square x) (* x x))

(define (square-tree l)
  (if (empty? l)
    '()
    (cons (cond ((number? (car l)) (square (car l)))
                ((list? (car l)) (square-tree (car l))))
          (square-tree (cdr l)))))

; using map

(define (square-tree l)
  (if (empty? l)
    '()
    (map (lambda (x) (cond ((number? x) (square x))
                            ((list? x) (square-tree x)))) l)))


(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

; => (1 (4 (9 16) 25) (36 49))

**PERFECT**
