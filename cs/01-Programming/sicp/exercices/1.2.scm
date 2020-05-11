; +---------------+
; | Exercise 1.20 |
; +---------------+

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

; normal order?
gcd(206, 40)
(gcd 40 (remainder 206 40))
(gcd (remainder(206 40)) (remainder 40 (remainder 206 40)))
(gcd (remainder 40 remainder(206 40)) (remainder (remainder(206 40)) (remainder 40 (remainder 206 40))))
(gcd ((remainder (remainder(206 40)) (remainder 40 (remainder 206 40)) (remainder (remainder (remainder 40 remainder(206 40)) (remainder(206 40)) (remainder 40 (remainder 206 40)))
(gcd (remainder (remainder (remainder 40 remainder(206 40)) (remainder (remainder(206 40) (remainder 40 (remainder 206 40)))
 (((remainder (remainder(206 40)) (remainder 40 (remainder 206 40)) ((remainder 40 remainder(206 40)) (remainder(206 40)) (remainder 40 (remainder 206 40))


; 18, I miss one somehow... can be calculated mathematically but yet again... need to learn math :'(

...


; applicative order
gcd(40 remainder(206 40))
gcd(6 remainder(40 6))
gcd(4 remainder(6 4))
gcd(2 remainder(4 2))
2
;4 times remainder called
