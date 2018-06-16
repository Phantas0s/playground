(define (pas row col)
  (cond((= col 0) 1)
        ((= col row ) 1)
        (else (+ (pas (- row 1) (- col 1)) (pas (- row 1) col)))))

