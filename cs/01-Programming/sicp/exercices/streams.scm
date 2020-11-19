; Stream support 

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map-v1 proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply stream-map
             (cons proc (map stream-cdr argstreams))))))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (stream-append s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (stream-append (stream-cdr s1) s2))))

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

; Stream of integers


(define ones (cons-stream 1 ones))
(define (add-streams s1 s2) (stream-map + s1 s2))
(define integers
  (cons-stream 1 (add-streams ones integers)))

; or

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

; Display streams

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (ss1 strm this all)
  (cond ((null? strm) '())
        ((= this 0) '(...))
        ((and (pair? strm) (promise? (cdr strm)))
         (cons (ss1 (stream-car strm) all all)
               (ss1 (stream-cdr strm) (- this 1) all)))
        (else strm)))

(define (show-stream strm . args) ;2nd arg is how many
  (if (null? args)
    (ss1 strm 10 10)
    (ss1 strm (car args) (car args))))
