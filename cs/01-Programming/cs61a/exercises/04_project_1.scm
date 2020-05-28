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

; Put Ace cards (including Ace) at the end of the card stack
(define (ace-last cards)
  (define (sort-cards-count cards acc)
    (cond ((equal? cards '()) acc)
          ((ace-card? (first cards)) (sort-cards-count (bf cards) (se acc (first cards))))
          (else (sort-cards-count (bf cards) (se (first cards) acc)))))
  (sort-cards-count cards '()))

(define (add-sentence-number s)
  (if (empty? s)
    0
    (+ (first s) (add-sentence-number (bf s)))))

(define (word->number s number)
  (if (empty? s)
    '()
    (se number (word->number (bf s) number))))

; Choose the optimum value an Ace can take
(define (best-ace-value total ace-cards)
  (define (choose-ace-values total ace-values)
    (let ((total-ace-value (add-sentence-number ace-values)))
      (cond ((= (length ace-values) total-ace-value) ace-values)
            ((> (+ total-ace-value total) 21) 
             (choose-ace-values total (se (bf ace-values) 1)))
            (else ace-values))))
  (add-sentence-number (choose-ace-values total (word->number ace-cards 11))))

(define (number-card? card)
  (number? (bl card)))

(define (value-number-card card)
  (bl card))

(define (card-value card)
  (cond ((image-card? card) 10)
        ((number-card? card) (value-number-card card))
        ((ace-card? card) 1)
        (else 0)))

(define (best-total cards)
  (define (calc-total cs total)
    (if (empty? cs)
      total
      (let  ((card (first cs)))
        ; if we see an Ace it means we are at the end of the hand (cards ordered with ace-last)
        (if (ace-card? card) 
          (calc-total '() (+ total (best-ace-value total cs)))
          (calc-total (bf cs) (+ total (card-value card)))))))
  (calc-total (ace-last cards) 0))

; Simple - two cards
; (best-total `(2S 2H))
; => 4

; One Ace (10)
; (best-total `(2S 2H AD))
; => 15

;  Ace (1)
; (best-total `(10S 10H AD))
; => 21

; (best-total `(AD AC 9h))
; => 21

;2. Design stop-at-17

(define (stop-at-17 hand card)
  (< (best-total hand) 17))

;3. play-n

(define (play-n strategy n)
  (define (play strategy n result)
    (if (= n 0) 
      result
      (play strategy (- n 1) (+ result (twenty-one strategy)))))
  (play strategy n 0))

;4. dealer-sensitive

(define (number-card-equal? card val)
  (cond ((empty? val) #f)
        ((not (number-card? card)) #f)
        (else (if (= (first val) (value-number-card card))
                #t
                (number-card-equal? card (bf val))))))


(define (dealer-sensitive hand card)
  (or (and (if (number-card? card)
             (number-card-equal? card '(7 8 9 10))
             (or (image-card? card) (ace-card? card)))
           (< (best-total hand) 17))
      (and (if (number-card? card)
             (number-card-equal? card '(2 3 4 5 6))
             #f)
           (< (best-total hand) 12))))

;5. stop-at

(define (stop-at n)
  (lambda (hand card) 
    (< (best-total hand) n)))

;6.Valentine's day 

(define (has-card? suit hand)
  (cond ((equal? hand '()) #f)
        ((equal? (last (first hand)) suit) #t)
        (else (has-card? suit (bf hand)))))

(define (valentine hand card)
  (if (has-card? 'H hand)
    ((stop-at 19) hand card)
    ((stop-at 17) hand card)))

;7.Generalize valentine 

(define (suit-strategy suit suit-strat no-suit-strat)
  (lambda (hand card) 
    (if (has-card? suit hand)
      (suit-strat hand card)
      (no-suit-strat hand card))))

(define (valentine hand card)
  ((suit-strategy 'H (stop-at 19) (stop-at 17)) hand card))

;8 majority

(define (majority strat-1 strat-2 strat-3)
  (lambda (hand card)
    (or (and (strat-1 hand card) (strat-2 hand card))
        (and (strat-1 hand card) (strat-3 hand card))
        (and (strat-2 hand card) (strat-3 hand card)))))
(twenty-one (majority stop-at-17 dealer-sensitive valentine))
