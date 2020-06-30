;; match.scm

;;; Copyright (C) 1993 by Matthew Wright and Brian Harvey

;;;     This program is free software; you can redistribute it and/or modify
;;;     it under the terms of the GNU General Public License as published by
;;;     the Free Software Foundation; either version 2 of the License, or
;;;     (at your option) any later version.
;;; 
;;;     This program is distributed in the hope that it will be useful,
;;;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;     GNU General Public License for more details.
;;; 
;;;     You should have received a copy of the GNU General Public License
;;;     along with this program; if not, write to the Free Software
;;;     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


(define (match pattern sent)
  (match-using-known-values pattern sent '()))

(define (match-using-known-values pattern sent known-values)
  (cond ((empty? pattern)
	 (if (empty? sent) known-values 'failed))
	((special? (first pattern))
	 (let ((placeholder (first pattern)))
	   (match-special (first placeholder)
			  (bf placeholder)
			  (bf pattern)
			  sent
			  known-values)))
	((empty? sent) 'failed)
	((equal? (first pattern) (first sent))
	 (match-using-known-values (bf pattern) (bf sent) known-values))
	(else 'failed)))

(define (special? wd)
  (member? (first wd) '(* & ? !)))

(define (match-special howmany name pattern-rest sent known-values)
  (let ((old-value (lookup name known-values)))
    (cond ((not (equal? old-value 'no-value))
	   (if (length-ok? old-value howmany)
	       (already-known-match
		  old-value pattern-rest sent known-values)
	       'failed))
	  ((equal? howmany '?)
	   (longest-match name pattern-rest sent 0 #t known-values))
	  ((equal? howmany '!)
	   (longest-match name pattern-rest sent 1 #t known-values))
	  ((equal? howmany '*)
	   (longest-match name pattern-rest sent 0 #f known-values))
	  ((equal? howmany '&)
	   (longest-match name pattern-rest sent 1 #f known-values)))))

(define (length-ok? value howmany)
  (cond ((empty? value) (member? howmany '(? *)))
	((not (empty? (bf value))) (member? howmany '(* &)))
	(else #t)))

(define (already-known-match value pattern-rest sent known-values)
  (let ((unmatched (chop-leading-substring value sent)))
    (if (not (equal? unmatched 'failed))
	(match-using-known-values pattern-rest unmatched known-values)
	'failed)))

(define (chop-leading-substring value sent)
  (cond ((empty? value) sent)
	((empty? sent) 'failed)
	((equal? (first value) (first sent))
	 (chop-leading-substring (bf value) (bf sent)))
	(else 'failed)))

(define (longest-match name pattern-rest sent min max-one? known-values)
  (cond ((empty? sent)
	 (if (= min 0)
	     (match-using-known-values pattern-rest
				       sent
				       (add name '() known-values))
	     'failed))
	(max-one?
	 (lm-helper name pattern-rest (se (first sent))
		    (bf sent) min known-values))
	(else (lm-helper name pattern-rest
			 sent '() min known-values))))

(define (lm-helper name pattern-rest
		   sent-matched sent-unmatched min known-values)
  (if (< (length sent-matched) min)
      'failed
      (let ((tentative-result (match-using-known-values
			       pattern-rest
			       sent-unmatched
			       (add name sent-matched known-values))))
	(cond ((not (equal? tentative-result 'failed)) tentative-result)
	      ((empty? sent-matched) 'failed)
	      (else (lm-helper name
			       pattern-rest
			       (bl sent-matched)
			       (se (last sent-matched) sent-unmatched)
			       min
			       known-values))))))

;;; Known values database abstract data type

(define (lookup name known-values)
  (cond ((empty? known-values) 'no-value)
	((equal? (first known-values) name)
	 (get-value (bf known-values)))
	(else (lookup name (skip-value known-values)))))

(define (get-value stuff)
  (if (equal? (first stuff) '!)
      '()
      (se (first stuff) (get-value (bf stuff)))))

(define (skip-value stuff)
  (if (equal? (first stuff) '!)
      (bf stuff)
      (skip-value (bf stuff))))

(define (add name value known-values)
  (if (empty? name)
      known-values
      (se known-values name value '!)))
