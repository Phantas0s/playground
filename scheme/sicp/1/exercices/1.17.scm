(define (* a b)
  (if (= b 0)
    0
    (+ a (* a (- b 1)))))

(define (double a) (+ a a))
(define (halve a) (/ a 2))

(define (even? n)
  (= (remainder n 2) 0))

(define (* a b)
  (cond ((= b 0) 0)
    ((even? b) (double (* a (halve b))))
    (else (double (* a (- b 1))))))

(3 4)
(double (3 2))
(double (double (3 1)))
(double (double (+ 3 1)))
(double (double 3))
(double 6)
12
