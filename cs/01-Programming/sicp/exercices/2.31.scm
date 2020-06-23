
; Abstract your answer to Exercise 2.30 to
; produce a procedure tree-map with the property that square-
; tree could be defined as

(define (square-tree tree) (tree-map square tree))

(define (square x) (* x x))

(define (tree-map square tree)
  (map (lambda (x) (cond ((number? x) (square x))
                            ((list? x) (tree-map square x)))) tree))
(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

; => (1 (4 (9 16) 25) (36 49))

(define tree (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

(tree-map (lambda (x) (+ x x)) tree)
  (map (lambda (x) (cond ((number? x) (square x))
                            ((list? x) (tree-map square x)))) tree)

; => '(2 (4 (6 8) 10) (12 14))

; **PERFECT**
