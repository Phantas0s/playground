; Consider the sequence of expressions

(define sum 0)
; => sum: 0
; **PERFECT**

(define (accum x) (set! sum (+ x sum)) sum)
; => sum: 0
; **PERFECT**

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))
; => sum: 1
; **PERFECT**

(define y (stream-filter even? seq))
; => sum: 3
; **WRONG**
; => sum: 1 + 2 + 3

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
; => sum: 3 + 4 + 5  = 12

(stream-ref y 7)
; => 16

(display-stream z)
; => (20 <promise>)

; What is the value of sum after each of the above expressions
; is evaluated? 

; What is the printed response to evaluating
; the stream-ref and display-stream expressions? 

; Would these responses differ if we had implemented (delay ⟨exp ⟩)
; simply as (lambda () ⟨exp ⟩) without using the optimiza-
; tion provided by memo-proc? Explain.

; The stream ref wouldn't have displayed 14 and 16 but would have displayed all the event numbers from 2, since they weren't memoized with memo-proc.



; DETAILED SOLUTION (http://community.schemewiki.org/?sicp-ex-3.52)

; +----------------+-------------+-------------+--------------+--------------+
; |                | SICP Scheme | SICP Scheme | Racket With  | Racket With  |
; |                |    With     |   Without   |    Text's    |   Built in   |
; | sum after:     | Memoization | Memoization | Map & Filter | Map & Filter |
; +----------------+-------------+-------------+--------------+--------------+
; | define accum   |        0    |       0     |        0     |        0     |
; +----------------+-------------+-------------+--------------+--------------+
; | define seq     |        1    |       1     |        0     |        0     |
; +----------------+-------------+-------------+--------------+--------------+
; | define y       |        6    |       6     |        6     |        0     |
; +----------------+-------------+-------------+--------------+--------------+
; | define z       |       10    |      15     |       10     |        0     |
; +----------------+-------------+-------------+--------------+--------------+
; | stream-ref     |      136    |     162     |      136     |      136     |
; +----------------+-------------+-------------+--------------+--------------+
; | display-stream |      210    |     362     |      210     |      210     |
; +----------------+-------------+-------------+--------------+--------------+

;   Printed response with memoization: 10, 15, 45, 55, 105, 120, 190, 210
;   Printed response without memoization: 15, 180, 230, 305
;   Printed response with Racket: 10, 15, 45, 55, 105, 120, 190, 210

; Unlike generators and streams from most languages, including modern Scheme,
; the first element of the stream is not delayed and is evaluated at creation
; time.  With memoization this doesn't make a difference to the elements of
; seq (and hence values of sum) as they are evaluated just once and always in
; the same order.  But without memoization several elements are evaluated more
; than once and the order in which they are evaluated will affect the values
; of seq.

; The lack of a delay for the first item of a stream is discussed in the
; Rationale of SRFI 41 (Scheme Request For Implementation) where Abelson and
; Sussman's implementation is described as 'odd' streams and this chapter of
; SICP is referenced for understanding 'odd' streams.  However, 'even' streams
; (Wadler et al), which do delay the first item, predominate today.

; The non-memoizing results were obtained by implementing a non-memoizing
; stream using the language implementation from Chapter 4.


; ============================================================================
; ==  With Memoization  ======================================================
; ============================================================================

; Call to define seq:
; ===================
;       sum:   0 |
;  interval:     | 1
; ---------------+--
;       seq:     | 1

; Call to define y:
; =================
;       sum:   1 |
;   car seq:   1 | 1
;  interval:   1 |   2 3
;       seq:     |   3 6
; ---------------+------
;         y:     | - - 6


; Call to define z:
; =================
;       sum:   6 |
;   car seq:   1 | 1
;     car y:   6 |
;  interval:   3 |        4
;       seq:     |       10
;  memoized:     |   3 6 
; ---------------+---------
;         z:     | - - - 10


; Call to stream-ref y 7
; ======================
;       sum:  10 |
;   car seq:   1 |
;     car y:   6 | 6  
;     car z:  10 |
;  interval:   4 |       5  6  7  8  9 10 11 12 13  14  15  16
;       seq:     |      15 21 28 36 45 55 66 78 91 105 120 136
;  memoized:     |   10
; ---------------+--------------------------------------------
;  stream-ref:   | 6 10  -  - 28 36  -  - 66 78  -   - 120 136


; Call to display-stream
; ======================
;       sum: 136 |
;   car seq:   1 |
;     car y:   6 |
;     car z:  10 | 10
;  interval:  16 |                                            17  18  19  20
;       seq:     |                                           153 171 190 210
;  memoized:     |    15 21 28 36 45 55 66 78 91 105 120 136
; ---------------+----------------------------------------------------------
; display-stream:| 10 15  -  -  - 45 55  -  -  - 105 120   -   -   - 190 210


; ============================================================================
; ==  Without Memoization  ===================================================
; ============================================================================

; Call to define seq:
; ===================
;       sum:   0 |
;  interval:     | 1
; ---------------+--
;       seq:     | 1

; Call to define y:
; =================
;       sum:   1 |
;   car seq:   1 | 1
;  interval:   1 |   2 3
;       seq:     |   3 6
; ---------------+------
;         y:     | - - 6


; Call to define z:
; =================
;       sum:   6 |
;   car seq:   1 | 1
;     car y:   6 |
;  interval:   1 |   2  3  4
;       seq:     |   8 11 15
; ---------------+----------
;         z:     | - -  - 15


; Call to stream-ref y 7
; ======================
;       sum:  15 |
;   car seq:   1 |
;     car y:   6 | 6
;     car z:  15 |
;  interval:   3 |    4  5  6  7  8  9 10 11 12  13  14  15  16  17
;       seq:     |   19 24 30 37 45 54 64 75 87 100 114 129 145 162
; ---------------+-------------------------------------------------
;  streamm-ref:  | 6  - 24 30  -  - 54 64  -  - 100 114   -   - 162

       
; Call to display-stream
; ======================
;       sum: 162 |
;   car seq:   1 |
;     car y:   6 |
;     car z:  15 | 15
;  interval:   4 |      5   6   7   8   9  10  11  12 ...  16  17  18  19  20
;       seq:     |    167 173 180 188 197 207 218 230 ... 288 305 323 342 362
; ---------------+-----------------------------------     -------------------
; display-stream:| 15   -   - 180   -   -   -   - 230 ...   - 305   -   -   -
