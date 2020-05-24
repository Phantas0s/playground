; return 1 => won
; return 0 => tied
; return -1 => lost

(define (twenty-one strategy)
  (define (play-dealer customer-hand dealer-hand-so-far rest-of-deck)
    (cond ((> (best-total dealer-hand-so-far) 21) 1)
          ((< (best-total dealer-hand-so-far) 17)
           (play-dealer customer-hand
                        (se dealer-hand-so-far (first rest-of-deck))
                        (bf rest-of-deck)))
          ((< (best-total customer-hand) (best-total dealer-hand-so-far)) -1)
          ((= (best-total customer-hand) (best-total dealer-hand-so-far)) 0)
          (else 1)))

  (define (play-customer customer-hand-so-far dealer-up-card rest-of-deck)
    (cond ((> (best-total customer-hand-so-far) 21) -1)
          ((strategy customer-hand-so-far dealer-up-card)
           (play-customer (se customer-hand-so-far (first rest-of-deck))
                          dealer-up-card
                          (bf rest-of-deck)))
          (else
            (play-dealer customer-hand-so-far
                         (se dealer-up-card (first rest-of-deck))
                         (bf rest-of-deck)))))

  (let ((deck (make-deck)))
    (play-customer (se (first deck) (first (bf deck)))
                   (first (bf (bf deck)))
                   (bf (bf (bf deck))))) )

(define (make-ordered-deck)
  (define (make-suit s)
    (every (lambda (rank) (word rank s)) '(A 2 3 4 5 6 7 8 9 10 J Q K)) )
  (se (make-suit 'H) (make-suit 'S) (make-suit 'D) (make-suit 'C)) )

(define (make-deck)
  (define (shuffle deck size)
    (define (move-card in out which)
      (if (= which 0)
        (se (first in) (shuffle (se (bf in) out) (- size 1)))
        (move-card (bf in) (se (first in) out) (- which 1)) ))
    (if (= size 0)
      deck
      (move-card deck '() (random size)) ))
  (shuffle (make-ordered-deck) 52) )

; 1. Write best total

(define (best-total s)
  (define (image-card? card)
    (or (equal? card 'J) (equal? card 'Q) (equal? card 'K)))
  (define (choose-ace-value total)
    (if (>= total 21)
      1
      10))
  (define (total st t)
    (if (empty? st)
      t
      (let ((card-type (bl (first st))))
        (let ((card-value (cond ((equal? card-type 'A) (choose-ace-value t))
                                ((image-card? card-type) 10) 
                                ((number? card-type) card-type)
                                (else 0))))
          (total (bf st) (+ t card-value))))))
  (total s 0))

; Simple - two cards
; (best-total `(2S 2H))
; => 4

; One As (10)
; (best-total `(2S 2H AD))
; => 14

;  As (1)
; (best-total `(10S 10H AD))
; => 21

; (best-total ’(ad as 9h))
; 29
; DOESN"T WORK - should be 21
