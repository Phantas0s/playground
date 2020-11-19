; Complete the following definition, which
; generalizes stream-map to allow procedures that take mul-
; tiple arguments, analogous to map in Section 2.2.1, Footnote


; (define (stream-map proc . argstreams)
;   (if (⟨??⟩ (car argstreams))
;     the-empty-stream
;     (⟨??⟩
;       (apply proc (map
;                     ⟨??⟩ argstreams))
;       (apply stream-map
;              (cons proc (map
;                           ⟨??⟩ argstreams))))))

; Normal map implementation

; (map + (list 1 2 3) (list 40 50 60) (list 700 800 900))
; (741 852 963)
; (map (lambda (x y) (+ x (* 2 y)))
;      (list 1 2 3)
;      (list 4 5 6))
; (9 12 15)

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply stream-map
             (cons proc (map stream-cdr argstreams))))))

; **PERFECT**

; tests

(define s (cons-stream 1 2))
(stream-car s)
(stream-cdr s)

(define t (stream-map + (cons-stream 1 (cons-stream 2 3))))
