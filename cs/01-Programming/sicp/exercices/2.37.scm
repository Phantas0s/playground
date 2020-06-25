(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map
    (lambda (x) (dot-product v x)) m))

(define (transpose mat)
  (accumulate-n
    cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map
      (lambda (x) (matrix-*-vector cols x)) m)))

(dot-product (list 1 2 3) (list 7 9 11))
; => 58

(define mat-1 (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))

(matrix-*-vector mat-1 (list 2 1 3))
; => '(13 31 49)

(transpose mat-1)
; => '((1 4 7) (2 5 8) (3 6 9))

(matrix-*-matrix mat-1 mat-1)

**PERFECT**
