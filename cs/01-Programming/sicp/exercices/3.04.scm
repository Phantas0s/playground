(define (make-account balance password)
  (let ((attempt 0)
        (limit 7)) 
    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (call-the-cops) (lambda (x) "The Cops are COMIN'!!!!!11"))
    (define (dispatch pass m)
      (if (eq? pass password)
        (begin (set! attempt 0) 
               (cond 
                 ((eq? m 'withdraw) withdraw)
                 ((eq? m 'deposit) deposit)
                 (else (error "Unknown request: MAKE-ACCOUNT"
                              m))))
        (begin (set! attempt (+ 1 attempt)) 
               (if (>= attempt limit)
               (call-the-cops)
               (lambda (x) "Incorrect Password")))))
    dispatch))

; **GOOD**

; See here for many other solutions, some of them keeping dispatch cleaner than my mess :D - http://community.schemewiki.org/?sicp-ex-3.4
; For a better job the password manager should be encapsulated into another, out of make-account function.
