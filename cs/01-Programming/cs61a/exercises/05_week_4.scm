; Write a procedure substitute that takes three arguments: a list, an old word, and a
; new word. It should return a copy of the list, but with every occurrence of the old word
; replaced by the new word, even in sublists. For example:

(define (substitute l old-word new-word)
  (define (sub l old-word new-word new-list)
  (if (empty? l)
      new-list
  (sub (cdr l) old-word new-word (append new-list (cond ((list? (car l)) (list (substitute (car l) old-word new-word)))
        ((equal? (car l) old-word) (list new-word))
        (else (list (car l))))))))
  (sub l old-word new-word '()))

(substitute '((lead guitar) (bass guitar) (rhythm guitar) drums)
            'guitar 'axe)
; ((lead axe) (bass axe) (rhythm axe) drums)


(substitute '((lead guitar (lead bass)) (bass guitar (drum guitar (drum axe))) (rhythm guitar) drums)
            'guitar 'axe)

**PERFECT**
