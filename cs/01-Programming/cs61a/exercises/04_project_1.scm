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

; J, Q and K cards
(define (image-card? card)
  (or (equal? (first card) 'J) (equal? (first card) 'Q) (equal? (first card) 'K)))

(define (ace-card? card)
  (equal? (first card) 'A))

; Put image cards (including As) at the end
(define (ace-last cards)
  (define (sort-cards-count cards acc)
    (cond ((equal? cards '()) acc)
          ((ace-card? (first cards)) (sort-cards-count (bf cards) (se acc (first cards))))
          (else (sort-cards-count (bf cards) (se (first cards) acc)))))
  (sort-cards-count cards '()))

; TODO needs to calculate ace-value with every ace, otherwise total not optimal
; (define (choose-ace-value total ace-cards)
;   (let ((ace-values (* (length ace-cards) 11)))
;     (if (<= (ace-values) 21)
;       (ace-values))))

(define (number-card? card)
  (number? (bl card)))

(define (value-number-card card)
  (bl card))

(define (best-total cards)
  (define (calc-total cs total)
    (if (empty? cs)
      total
      (let  ((card (first cs)))
        (let ((card-value (cond ((image-card? card) 10)
                                ((number-card? card) (value-number-card card))
                                ((ace-card? card) (choose-ace-value cs total))
                                (else 0))))
          (calc-total (bf cs) (+ total card-value))))))
  (calc-total (ace-last cards) 0))

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
