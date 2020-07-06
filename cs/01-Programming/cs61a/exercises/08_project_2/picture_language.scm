; 2.2.4 Example: A Picture Language (p 172 of SICP)

(define wave2 (beside wave (flip-vert wave)))
(define wave4 (below wave2 wave2))

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define wave4 (flipped-pairs wave))

(define (right-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (right-split painter (- n 1))))
      (beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
    painter
    (let ((up (up-split painter (- n 1)))
          (right (right-split painter (- n 1))))
      (let ((top-left (beside up up))
            (bottom-right (below right right))
            (corner (corner-split painter (- n 1))))
        (beside (below painter top-left)
                (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

; +---------------+
; | exercise 2.44 |
; +---------------+

(define (up-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (up-split painter (- n 1))))
      (below painter (beside smaller smaller)))))

; **PERFECT**

; ----------------+

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))


; +---------------+
; | exercise 2.45 |
; +---------------+


; right-split and up-split can be expressed
; as instances of a general splitting operation. Define a pro-
; cedure split with the property that evaluating

(define right-split (split beside below))
(define up-split (split below beside))

; produces procedures right-split and up-split with the
; same behaviors as the ones already defined.

(define (split orig splitted)
  (lambda (painter n)
    (if (= n 0) 
      painter
      (let ((smaller ((split orig splitted) painter (- n 1))))
        (orig painter (splitted smaller smaller))))))

**GOOD**

; ----------------+


(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                (scale-vect (ycor-vect v) (edge2-frame frame))))))


; +---------------+
; | exercise 2.46 |
; +---------------+

; A two-dimensional vector v running from
; the origin to a point can be represented as a pair consisting
; of an x-coordinate and a y-coordinate. Implement a data
; abstraction for vectors by giving a constructor make-vect
; and corresponding selectors xcor-vect and ycor-vect. In
; terms of your selectors and constructor, implement proce-
; dures add-vect, sub-vect, and scale-vect that perform
; the operations vector addition, vector subtraction, and mul-
; tiplying a vector by a scalar:

; (x 1 , y1 ) + (x 2 , y2 ) = (x 1 + x 2 , y 1 + y2 ),
; (x 1 , y 1 ) − (x 2 , y2 ) = (x 1 − x2 , y1 − y 2 ),
; s · (x , y) = (sx , sy).

(define (make-vect x y)
  (list x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cadr vect))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
        (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
        (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect scalar vect)
  (make-vect (* scalar (xcor-vect vect))
        (* scalar (ycor-vect vect))))

**PERFECT**

; +---------------+
; | exercise 2.47 |
; +---------------+

; Here are two possible constructors for frames:

(define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))

(define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))

; For each constructor supply the appropriate selectors to
; produce an implementation for frames.

; first constructor

(define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

; second constructor

(define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (list (caddr frame) (cadddr frame)))

; better solution:
; (define (edge2-frame frame)
;   (cddr frame))

**GOOD**

; -----------------


(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
      (lambda (segment)
        (draw-line
          ((frame-coord-map frame)
           (start-segment segment))
          ((frame-coord-map frame)
           (end-segment segment))))
      segment-list)))

; +---------------+
; | exercise 2.48 |
; +---------------+

(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cadr s))

**PEFECT**

; +---------------+
; | exercise 2.49 |
; +---------------+

; Use segments->painter to define the fol-
; lowing primitive painters:

; a. The painter that draws the outline of the designated
; frame.

; b. The painter that draws an “X” by connecting opposite
; corners of the frame.

; c. The painter that draws a diamond shape by connect-
; ing the midpoints of the sides of the frame.

; d. The wave painter.


