(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))

(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))


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

**PERFECT**

; tests

(define s (cons-stream 1 2))
(stream-car s)
(stream-cdr s)

(define t (stream-map + (cons-stream 1 (cons-stream 2 3))))
