; In the make-withdraw procedure, the local
; variable balance is created as a parameter of make-withdraw.
; We could also create the local state variable explicitly, us-
; ing let, as follows:

(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))))

; Recall from Section 1.3.2 that let is simply syntactic sugar
; for a procedure call:

; (let ((⟨var⟩ ⟨exp⟩)) ⟨body⟩)

; is interpreted as an alternate syntax for

; ((lambda (⟨var⟩) ⟨body⟩ ) ⟨exp⟩)

; Use the environment model to analyze this alternate ver-
; sion of make-withdraw, drawing figures like the ones above
; to illustrate the interactions

(define W1 (make-withdraw 100))
(W1 50)
(define W2 (make-withdraw 100))

; Show that the two versions of make-withdraw create ob-
; jects with the same behavior. How do the environment struc-
; tures differ for the two versions?

; W1 and W2 environments have a frame which point both to the global environment. However, both frame for W1 and W2 are in different environments. Modifying the balance for W1 won't affect W2's balance.

**GOOD**
