(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map
    (lambda (x) (dot-product x v)) m))

(define (transpose mat)
  (accumulate-n
    ⟨??⟩ ⟨??⟩ mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map
      (lambda (x) (matrix-*-vector n)) m)))


(dot-product (list 1 2 3) (list 7 9 11))
; => 58

(matrix-*-vector (list (list 1 2 3) (list 4 5 6) (list 7 8 9)) (list 2 1 3))
; => '(13 31 49)

; (matrix-*-matrix (list (list 1 2 3) (list 4 5 6)) (list (list 7 8) (list 9 10) (list 11 12)))
