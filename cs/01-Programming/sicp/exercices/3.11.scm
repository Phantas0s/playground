; In Section 3.2.3 we saw how the environ-
; ment model described the behavior of procedures with local
; state. Now we have seen how internal definitions work. A
; typical message-passing procedure contains both of these
; aspects. Consider the bank account procedure of Section
; 3.1.1:

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
            (error "Unknown request: MAKE-ACCOUNT"
                   m))))
  dispatch)

; Show the environment structure generated by the sequence
; of interactions

(define acc (make-account 50))
((acc 'deposit) 40)
90
((acc 'withdraw) 60)
30

; Where is the local state for acc kept? Suppose we define
; another account

; **WRONG**

; I did mistakes on the diagram (See ./3.11_diagram.pdf)
; 1. The frame of a procedure always point where the procedure were defined. 
; 2. A procedure can be called even if its formal parameters are not bound. However, I wonder how it works for something like the let of exercise 3.10
; 3. When a procedure has been drawn, I shouldn't draw it again when it's called with a different argument. What I should put in the argument of the procedure (the two bubbles) is the argument itself, not its bound value!


(define acc2 (make-account 100))

; How are the local states for the two accounts kept distinct?
; Which parts of the environment structure are shared be-
; tween acc and acc2?

; The only env which is shared is the global one

; **GOOD**

; Good diagram


; (define acc (make-account 50))

; global   _________________________________
; env  -->| make-account :*                 |
;         | acc : *       |                 |
;          -------|-------|---^-----------^-
;                 |       |   |           |
;                 |     ( * , * )         |
;                 |       |               |
;                         parameter: balance
;                 |       body: (define (withdraw ... ))
;                 |                       |
;                 |                -------Frame 0-      (parameter, body)
;                 |               | balance  : 50 |      |
;                 |           E0->| withdraw : *--|--> ( * , * )
;                 |               | deposit  : *--|--> ( * , * )
;                 |               | dispatch : *--|--> ( * , * )
;                 |                -------^----^--           |
;                 |    ___________________|    |_____________|
;                 |   |
;               ( * , * )
;                 |
;                 parameter : m
;                 body      : (cond ((eq? m ... )))

; ((acc 'deposit) 40)

; Frame 1 is created when (acc 'deposit is evaluated).
; Next, Frame 2 is created when (deposit amount). Since deposit is defined
; in E0, Frame 2 pointer is to environment E0.

; global   _________________________________
; env  -->| make-account :*                 |
;         | acc : *                         |
;          -------|-----------------------^-
;                 |                       |
;                 |                -------Frame 0-
;                 |               | balance  : 50 |
;               ( *, *-)--------->| withdraw : *  |
;                                 | deposit  : *  |<- E0
;                                 | dispatch : *  |
;                                  -^-----^------- (make-account balance)
;                          _________|     |
;                         |        -------Frame 1-
;                         |       | m : 'deposit  |<- E1
;                         |        --------------- (dispatch m)
;                  -------Frame 2-
;                 | amount : 40   |<- E2
;                  --------------- (deposit amount)

; After ((acc 'deposit) 40) evaluation balance is set to 90 in Frame 0 and
; Frames 1 and 2 are not relevant anymore.

; global   _________________________________
; env  -->| make-account :*                 |
;         | acc : *                         |
;          -------|-----------------------^-
;                 |                       |
;                 |                -------Frame 0-
;                 |               | balance  : 90 |
;               ( *, *-)--------->| withdraw : *  |
;                                 | deposit  : *  |<- E0
;                                 | dispatch : *  |
;                                  ---------------

; ((acc 'withdraw) 60)

; global   _________________________________
; env  -->| make-account :*                 |
;         | acc : *                         |
;          -------|-----------------------^-
;                 |                       |
;                 |                -------Frame 0-
;                 |               | balance  : 90 |
;               ( *, *-)--------->| withdraw : *  |
;                                 | deposit  : *  |<- E0
;                                 | dispatch : *  |
;                                  -^-----^------- (make-account balance)
;                          _________|     |
;                         |        -------Frame 3-
;                         |       | m : 'withdraw |<- E3
;                         |        --------------- (dispatch m)
;                  -------Frame 4-
;                 | amount : 60   |<- E4
;                  --------------- (withdraw amount)

; After ((acc 'withdraw) 60)

; global   _________________________________
; env  -->| make-account :*                 |
;         | acc : *                         |
;          -------|-----------------------^-
;                 |                       |
;                 |                -------Frame 0-
;                 |               | balance  : 30 |
;               ( *, *-)--------->| withdraw : *  |
;                                 | deposit  : *  |<- E0
;                                 | dispatch : *  |
;                                  ---------------
