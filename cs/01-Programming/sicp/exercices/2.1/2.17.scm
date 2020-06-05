(define (last-pair l)
    (if (= (length l) 1)
      (car l)
      (last-pair (cdr l))))

**PERFECT**
