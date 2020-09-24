; One dimension

(define (make-table) (list '*table*))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
      (cdr record)
      false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
      (set-cdr! record value)
      (set-cdr! table
                (cons (cons key value)
                      (cdr table)))))
  'ok)

; Two dimensions

(define (make-table)
  (list '*table*))


(define (lookup key-1 key-2 table)
  (let ((subtable
          (assoc key-1 (cdr table))))
    (if subtable
      (let ((record
              (assoc key-2 (cdr subtable))))
        (if record
          (cdr record)
          false))
      false)))

(define (insert! key-1 key-2 value table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
      (let ((record (assoc key-2 (cdr subtable))))
        (if record
          (set-cdr! record value)
          (set-cdr! subtable
                    (cons (cons key-2 value)
                          (cdr subtable)))))
      (set-cdr! table
                (cons (list key-1
                            (cons key-2 value))
                      (cdr table)))))
  'ok)

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable
              (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record
                  (assoc key-2 (cdr subtable))))
            (if record (cdr record) false))
          false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable
              (assoc key-1 (cdr local-table))))
        (if subtable
          (let ((record
                  (assoc key-2 (cdr subtable))))
            (if record
              (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key-2 value)
                              (cdr subtable)))))
          (set-cdr! local-table
                    (cons (list key-1 (cons key-2 value))
                          (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

; Exercise 3.25: Generalizing one- and two-dimensional ta-
; bles, show how to implement a table in which values are
; stored under an arbitrary number of keys and different val-
; ues may be stored under different numbers of keys. The
; lookup and insert! procedures should take as input a list
; of keys used to access the table.

(define (lookup keys table)
  (if (empty? keys)
    #f
    (let ((element (assoc (car keys) (cdr table))))
      (cond ((not element) #f)
            ((pair? (cdr element)) (lookup (cdr keys) element))
            (else (cdr element))))))

(define (insert! keys value table)
  (if (empty? keys)
    #f
    (let ((element (assoc (car keys) (cdr table))))
      (cond ((not element) (add-keys! keys value table))
            ((pair? (cdr element)) (lookup (cdr keys) element))))))

(define (add-keys! keys value table)
  (cond ((empty? keys) 'ok)
        ((= (length keys) 1) 
         (set-cdr! table
                   (cons (cons (car keys) value)
                         (cdr table))))
        (else (set-cdr! table
                        (cons (list (car keys))
                              (cdr table)))
              (add-keys! (cdr keys) value (cdadr table)))))
