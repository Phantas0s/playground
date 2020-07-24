; Implement the constructor make-from-mag-
; ang in message-passing style. This procedure should be anal-
; ogous to the make-from-real-imag procedure given above.

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else (error "Unknown op: make-from-mag-ang" op))))
dispatch)

**PERFECT**


