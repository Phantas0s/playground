; Consider the bank account objects created by
; make-account, with the password modification described
; in Exercise 3.3. 

; Suppose that our banking system requires
; the ability to make joint accounts. Define a procedure make-
; joint that accomplishes this. 

; make-joint should take three arguments. 
; The first is a password-protected account. 
; The second argument must match the password with which the account was defined in order for the make-joint operation to proceed. 
; The third argument is a new password. make-joint is to create an additional access to the original 
; account using the new password. For example, if peter-acc is a bank account with password open-sesame, then

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

; will allow one to make transactions on peter-acc using the
; name paul-acc and the password rosebud. You may wish
; to modify your solution to Exercise 3.3 to accommodate this
; new feature.

(define (verify-passwords list-pass pass)
  (cond ((eq? list-pass '()) #f)
        ((eq? pass (car list-pass)) #t)
        (else (verify-passwords (cdr list-pass) pass))))

(define (make-account balance password)
  (let ((passwords (list password))) 

    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))

    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)

    (define (add-password p)
      (set! passwords (cons p passwords)))

    (define (dispatch pass m)
      (if (verify-passwords passwords pass)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              ((eq? m 'add-password) add-password)
              (else (error "Unknown request: MAKE-ACCOUNT"
                           m)))
        (error "Incorrect Password")))
    dispatch))


(define (make-joint acc password new-password)
  (begin ((acc password 'add-password) new-password))
  acc)

; **GOOD**
; My solution allow to access the original account with the new password; since it wasn't really clearly mentioned in the text, I consider it as valid ;p.
; I did too many years of OOP...

; Another good solution

(define (make-account balance pass-origin) 
  (define (withdraw amount) 
    (if (>= balance amount) 
      (begin (set! balance (- balance amount)) 
             balance) 
      "Insufficient funds")) 

  (define (deposit amount) 
    (set! balance (+ balance amount)) 
    balance) 

  (define (make-joint another-pass) 
    (dispatch another-pass)) 

  (define (dispatch password) 
    (lambda (pass m) 
      (if (eq? pass password) 
        (cond ((eq? m 'withdraw) withdraw) 
              ((eq? m 'deposit) deposit) 
              ((eq? m 'make-joint) make-joint) 
              (else (error "Unknown request -- MAKE-ACCOUNT" 
                           m))) 
        (lambda (x) "Incorrect password")))) 
  (dispatch pass-origin)) 
