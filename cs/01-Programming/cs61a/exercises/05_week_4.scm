; +------------+
; | Exercise 1 |
; +------------+

; Write a procedure substitute that takes three arguments: a list, an old word, and a
; new word. It should return a copy of the list, but with every occurrence of the old word
; replaced by the new word, even in sublists. For example:

(define (substitute l old-word new-word)
  (define (sub l old-word new-word new-list)
    (if (empty? l)
      new-list
      (sub (cdr l) old-word new-word (append new-list 
                                             (cond ((list? (car l)) (list (substitute (car l) old-word new-word)))
                                                   ((equal? (car l) old-word) (list new-word))
                                                   (else (list (car l))))))))
  (sub l old-word new-word '()))

(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums)
            'guitar 'axe)
; => ((lead axe) (bass axe) (rhythm axe) drums)

(substitute '((lead guitar (lead bass)) (bass guitar (drum guitar (drum axe))) (rhythm guitar) drums)
            'guitar 'axe)
; => '((lead axe (lead bass)) (bass axe (drum axe (drum axe))) (rhythm axe) drums)

**PERFECT**

; +------------+
; | Exercise 2 |
; +------------+


; Now write substitute2 that takes a list, a list of old words, and a list of new words; the
; last two lists should be the same length. It should return a copy of the first argument, but
; with each word that occurs in the second argument replaced by the corresponding word of
; the third argument:
; (substitute2 '((4 calling birds) (3 french hens) (2 turtle doves))
; '(1 2 3 4) '(one two three four))
; ((four calling birds) (three french hens) (two turtle doves))

(define (substitute2 l old new)
  (define (sub l old-list new-list result)
    (if (empty? l)
      result
      (sub (cdr l) old-list new-list (append result 
                                             (cond ((list? (car l)) (list (substitute2 (car l) old-list new-list)))
                                                   (else (list (replace (car l) old-list new-list))))))))
  (sub l old new '()))

(define (replace value old-list new-list)
  (if (= (length old-list) (length new-list))
    (if (empty? old-list)
      value
      (cond ((equal? value (car old-list)) (car new-list))
            (else (replace value (cdr old-list) (cdr new-list)))))
    (error "old list and new list need to have the same size")))

**PERFECT**
