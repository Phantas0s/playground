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

; **PERFECT**

(define v1 (make-vect 1 1))
(define v2 (make-vect 1 2))
(define v3 (make-vect 1 2))

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

; **GOOD**

(define f1 (make-frame v1 v2 v3))

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

; **PEFECT**

(define s1 (make-segment v1 v2))
(define s2 (make-segment v2 v3))

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

(define (outline-segments frame)
  (let ((v0 (origin-frame frame))
        (v1 (edge1-frame frame))
        (v2 (edge2-frame frame))) 
    (list (make-segment v0 v1)
          (make-segment v0 e2)
          (make-segment e2  )
          (make-segment (edge1-frame frame) (origin-frame frame)))))

(define (outline-painter frame)
  ((segments->painter (outline-segments frame))) frame)

;(define (outline->painter frame) 
;   (let ((origin2 (make-vect  
;                   (- (xcor-vect (edge2-frame frame))  
;                      (xcor-vect (origin-frame frame))) 
;                   (- (ycor-vect (edge1-frame frame))  
;                      (ycor-vect (origin-frame frame)))))) 
;     (segments->painter  
;      (list           
;       (make-segment (origin-frame frame) (edge1-frame frame)) 
;       (make-segment (edge1-frame frame) origin2) 
;       (make-segment origin2 (edge2-frame frame)) 
;       (make-segment (edge2-frame frame) (origin-frame frame)))))) 
  
; (define (X->painter frame) 
;   (let ((origin2 (make-vect  
;                   (- (xcor-vect (edge2-frame frame))  
;                      (xcor-vect (origin-frame frame))) 
;                   (- (ycor-vect (edge1-frame frame))  
;                      (ycor-vect (origin-frame frame)))))) 
;     (segments->painter  
;      (list           
;       (make-segment (origin-frame frame) origin2) 
;       (make-segment (edge1-frame frame) (edge2-frame frame)))))) 
  
; (define (diamond->painter frame) 
;   (let ((midpoint1 (sub-vect (edge1-frame frame) (origin-frame frame)))  
;         (midpoint2 (sub-vect origin2 (edge1-frame frame)))  
;         (midpoint3 (sub-vect origin2 (edge2-frame frame))) 
;         (midpoint4 (sub-vect (edge2-frame frame) (origin-frame frame)))) 
;     (segments->painter  
;      (list           
;       (make-segment midpoint1 midpoint2) 
;       (make-segment midpoint2 midpoint3) 
;       (make-segment midpoint3 midpoint4) 
;       (make-segment midpoint4 midpoint1))))) 
  
; (define wave 
;   (segments->painter (list 
;                       (make-segment (make-vect .25 0) (make-vect .35 .5)) 
;                       (make-segment (make-vect .35 .5) (make-vect .3 .6)) 
;                       (make-segment (make-vect .3 .6) (make-vect .15 .4)) 
;                       (make-segment (make-vect .15 .4) (make-vect 0 .65)) 
;                       (make-segment (make-vect 0 .65) (make-vect 0 .85)) 
;                       (make-segment (make-vect 0 .85) (make-vect .15 .6)) 
;                       (make-segment (make-vect .15 .6) (make-vect .3 .65)) 
;                       (make-segment (make-vect .3 .65) (make-vect .4 .65)) 
;                       (make-segment (make-vect .4 .65) (make-vect .35 .85)) 
;                       (make-segment (make-vect .35 .85) (make-vect .4 1)) 
;                       (make-segment (make-vect .4 1) (make-vect .6 1)) 
;                       (make-segment (make-vect .6 1) (make-vect .65 .85)) 
;                       (make-segment (make-vect .65 .85) (make-vect .6 .65)) 
;                       (make-segment (make-vect .6 .65) (make-vect .75 .65)) 
;                       (make-segment (make-vect .75 .65) (make-vect 1 .35)) 
;                       (make-segment (make-vect 1 .35) (make-vect 1 .15)) 
;                       (make-segment (make-vect 1 .15) (make-vect .6 .45)) 
;                       (make-segment (make-vect .6 .45) (make-vect .75 0)) 
;                       (make-segment (make-vect .75 0) (make-vect .6 0)) 
;                       (make-segment (make-vect .6 0) (make-vect .5 .3)) 
;                       (make-segment (make-vect .5 .3) (make-vect .4 0)) 
;                       (make-segment (make-vect .4 0) (make-vect .25 0)) 
;                       ))) 
; ;George! 
  
; I don't how to solve the exercise or the solutions found on Internet. THe one below looks the most approapriate (it seems to me that we need to define the painter in term of a frame), but I don't understand why you should substract the points from origin for origin2.

; I need to go back to some algebra I guess. It's on my study map.

; **PASS** **WRONG**

; -----------------


(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                   new-origin
                   (sub-vect (m corner1) new-origin)
                   (sub-vect (m corner2) new-origin)))))))


(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0) ; new origin
                     (make-vect 1.0 1.0) ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2

(define (shrink-to-upper-right painter)
  (transform-painter
    painter (make-vect 0.5 0.5)
    (make-vect 1.0 0.5) (make-vect 0.5 1.0)))


(define (shrink-to-upper-right painter)
  (transform-painter
    painter (make-vect 0.5 0.5)
    (make-vect 1.0 0.5) (make-vect 0.5 1.0)))


(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))


(define (squash-inwards painter)
  (transform-painter painter
                     (make-vect 0.0 0.0)
                     (make-vect 0.65 0.35)
                     (make-vect 0.35 0.65)))


(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
            (transform-painter
              painter1
              (make-vect 0.0 0.0)
              split-point
              (make-vect 0.0 1.0)))
          (paint-right
            (transform-painter
              painter2
              split-point
              (make-vect 1.0 0.0)
              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))


