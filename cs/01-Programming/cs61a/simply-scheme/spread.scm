;; spread.scm

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


(define (spreadsheet)
  (init-array)
  (set-selection-cell-id! (make-id 1 1))
  (set-screen-corner-cell-id! (make-id 1 1))
  (command-loop))

(define (command-loop)
  (print-screen)
  (let ((command-or-formula (read)))
    (if (equal? command-or-formula 'exit)
	"Bye!"
	(begin (process-command command-or-formula)
	       (command-loop)))))

(define (process-command command-or-formula)
  (cond ((and (list? command-or-formula)
	      (command? (car command-or-formula)))
	 (execute-command command-or-formula))
	((command? command-or-formula)
	 (execute-command (list command-or-formula 1)))
	(else (exhibit (ss-eval (pin-down command-or-formula
					  (selection-cell-id)))))))

(define (execute-command command)
  (apply (get-command (car command))
	 (cdr command)))

(define (exhibit val)
  (show val)
  (show "Type RETURN to redraw screen")
  (read-line)
  (read-line))


;;; Commands

;; Cell selection commands: F, B, N, P, and SELECT

(define (prev-row delta)
  (let ((row (id-row (selection-cell-id))))
    (if (< (- row delta) 1)
	(error "Already at top.")
	(set-selected-row! (- row delta)))))

(define (next-row delta)
  (let ((row (id-row (selection-cell-id))))
    (if (> (+ row delta) 30)
	(error "Already at bottom.")
	(set-selected-row! (+ row delta)))))

(define (prev-col delta)
  (let ((col (id-column (selection-cell-id))))
    (if (< (- col delta) 1)
	(error "Already at left.")
	(set-selected-column! (- col delta)))))

(define (next-col delta)
  (let ((col (id-column (selection-cell-id))))
    (if (> (+ col delta) 26)
	(error "Already at right.")
	(set-selected-column! (+ col delta)))))

(define (set-selected-row! new-row)
  (select-id! (make-id (id-column (selection-cell-id)) new-row)))

(define (set-selected-column! new-column)
  (select-id! (make-id new-column (id-row (selection-cell-id)))))

(define (select-id! id)
  (set-selection-cell-id! id)
  (adjust-screen-boundaries))

(define (select cell-name)
  (select-id! (cell-name->id cell-name)))

(define (adjust-screen-boundaries)
  (let ((row (id-row (selection-cell-id)))
	(col (id-column (selection-cell-id))))
    (if (< row (id-row (screen-corner-cell-id)))
	(set-corner-row! row)
	'do-nothing)
    (if (>= row (+ (id-row (screen-corner-cell-id)) 20))
	(set-corner-row! (- row 19))
	'do-nothing)
    (if (< col (id-column (screen-corner-cell-id)))
	(set-corner-column! col)
	'do-nothing)
    (if (>= col (+ (id-column (screen-corner-cell-id)) 6))
	(set-corner-column! (- col 5))
	'do-nothing)))

(define (set-corner-row! new-row)
  (set-screen-corner-cell-id!
   (make-id (id-column (screen-corner-cell-id)) new-row)))

(define (set-corner-column! new-column)
  (set-screen-corner-cell-id!
   (make-id new-column (id-row (screen-corner-cell-id)))))


;; LOAD

(define (spreadsheet-load filename)
  (let ((port (open-input-file filename)))
    (sl-helper port)
    (close-input-port port)))

(define (sl-helper port)
  (let ((command (read port)))
    (if (eof-object? command)
	'done
	(begin (show command)
	       (process-command command)
	       (sl-helper port)))))


;; PUT

(define (put formula . where)
  (cond ((null? where)
	 (put-formula-in-cell formula (selection-cell-id)))
	((cell-name? (car where))
	 (put-formula-in-cell formula (cell-name->id (car where))))
	((number? (car where))
	 (put-all-cells-in-row formula (car where)))
	((letter? (car where))
	 (put-all-cells-in-col formula (letter->number (car where))))
	(else (error "Put it where?"))))

(define (put-all-cells-in-row formula row)
  (put-all-helper formula (lambda (col) (make-id col row)) 1 26))

(define (put-all-cells-in-col formula col)
  (put-all-helper formula (lambda (row) (make-id col row)) 1 30))

(define (put-all-helper formula id-maker this max)
  (if (> this max)
      'done
      (begin (try-putting formula (id-maker this))
	     (put-all-helper formula id-maker (+ 1 this) max))))

(define (try-putting formula id)
  (if (or (null? (cell-value id)) (null? formula))
      (put-formula-in-cell formula id)
      'do-nothing))

(define (put-formula-in-cell formula id)
  (put-expr (pin-down formula id) id))


;;; The Association List of Commands

(define (command? name)
  (assoc name *the-commands*))

(define (get-command name)
  (let ((result (assoc name *the-commands*)))
    (if (not result)
	#f
	(cadr result))))

(define *the-commands*
  (list (list 'p prev-row)
	(list 'n next-row)
	(list 'b prev-col)
	(list 'f next-col)
	(list 'select select)
	(list 'put put)
	(list 'load spreadsheet-load)))


;;; Pinning Down Formulas Into Expressions

(define (pin-down formula id)
  (cond ((cell-name? formula) (cell-name->id formula))
	((word? formula) formula)
	((null? formula) '())
	((equal? (car formula) 'cell)
	 (pin-down-cell (cdr formula) id))
	(else (bound-check
	       (map (lambda (subformula) (pin-down subformula id))
		    formula)))))

(define (bound-check form)
  (if (member 'out-of-bounds form)
      'out-of-bounds
      form))

(define (pin-down-cell args reference-id)
  (cond ((null? args)
	 (error "Bad cell specification: (cell)"))
	((null? (cdr args))
	 (cond ((number? (car args))         ; they chose a row
		(make-id (id-column reference-id) (car args)))
	       ((letter? (car args))         ; they chose a column
		(make-id (letter->number (car args))
			 (id-row reference-id)))
	       (else (error "Bad cell specification:"
			    (cons 'cell args)))))
	(else
	 (let ((col (pin-down-col (car args) (id-column reference-id)))
	       (row (pin-down-row (cadr args) (id-row reference-id))))
	   (if (and (>= col 1) (<= col 26) (>= row 1) (<= row 30))
	       (make-id col row)
	       'out-of-bounds)))))

(define (pin-down-col new old)
  (cond ((equal? new '*) old)
	((equal? (first new) '>) (+ old (bf new)))
	((equal? (first new) '<) (- old (bf new)))
	((letter? new) (letter->number new))
	(else (error "What column?"))))

(define (pin-down-row new old)
  (cond ((number? new) new)
	((equal? new '*) old)
	((equal? (first new) '>) (+ old (bf new)))
	((equal? (first new) '<) (- old (bf new)))
	(else (error "What row?"))))


;;; Dependency Management

(define (put-expr expr-or-out-of-bounds id)
  (let ((expr (if (equal? expr-or-out-of-bounds 'out-of-bounds)
		  '()
		  expr-or-out-of-bounds)))
    (for-each (lambda (old-parent)
		(set-cell-children!
		 old-parent
		 (remove id (cell-children old-parent))))
	      (cell-parents id))
    (set-cell-expr! id expr)
    (set-cell-parents! id (remdup (extract-ids expr)))
    (for-each (lambda (new-parent)
		(set-cell-children!
		 new-parent
		 (cons id (cell-children new-parent))))
	      (cell-parents id))
    (figure id)))

(define (extract-ids expr)
  (cond ((id? expr) (list expr))
	((word? expr) '())
	((null? expr) '())
	(else (append (extract-ids (car expr))
		      (extract-ids (cdr expr))))))

(define (figure id)
  (cond ((null? (cell-expr id)) (setvalue id '()))
	((all-evaluated? (cell-parents id))
	 (setvalue id (ss-eval (cell-expr id))))
	(else (setvalue id '()))))

(define (all-evaluated? ids)
  (cond ((null? ids) #t)
	((not (number? (cell-value (car ids)))) #f)
	(else (all-evaluated? (cdr ids)))))

(define (setvalue id value)
  (let ((old (cell-value id)))
    (set-cell-value! id value)
    (if (not (equal? old value))
	(for-each figure (cell-children id))
	'do-nothing)))


;;; Evaluating Expressions

(define (ss-eval expr)
  (cond ((number? expr) expr)
	((quoted? expr) (quoted-value expr))
	((id? expr) (cell-value expr))
	((invocation? expr)
	 (apply (get-function (car expr))
		(map ss-eval (cdr expr))))
	(else (error "Invalid expression:" expr))))

(define (quoted? expr)
  (or (string? expr)
      (and (list? expr) (equal? (car expr) 'quote))))

(define (quoted-value expr)
  (if (string? expr)
      expr
      (cadr expr)))

(define (invocation? expr)
  (list? expr))

(define (get-function name)
  (let ((result (assoc name *the-functions*)))
    (if (not result)
	(error "No such function: " name)
	(cadr result))))

(define *the-functions*
  (list (list '* *)
	(list '+ +)
	(list '- -)
	(list '/ /)
	(list 'abs abs)
	(list 'acos acos)
	(list 'asin asin)
	(list 'atan atan)
	(list 'ceiling ceiling)
	(list 'cos cos)
	(list 'count count)
	(list 'exp exp)
	(list 'expt expt)
	(list 'floor floor)
	(list 'gcd gcd)
	(list 'lcm lcm)
	(list 'log log)
	(list 'max max)
	(list 'min min)
	(list 'modulo modulo)
	(list 'quotient quotient)
	(list 'remainder remainder)
	(list 'round round)
	(list 'sin sin)
	(list 'sqrt sqrt)
	(list 'tan tan)
	(list 'truncate truncate)))

;;; Printing the Screen

(define (print-screen)
  (newline)
  (newline)
  (newline)
  (show-column-labels (id-column (screen-corner-cell-id)))
  (show-rows 20
	     (id-column (screen-corner-cell-id))
	     (id-row (screen-corner-cell-id)))
  (display-cell-name (selection-cell-id))
  (display ":  ")
  (show (cell-value (selection-cell-id)))
  (display-expression (cell-expr (selection-cell-id)))
  (newline)
  (display "?? "))

(define (display-cell-name id)
  (display (number->letter (id-column id)))
  (display (id-row id)))

(define (show-column-labels col-number)
  (display "  ")
  (show-label 6 col-number)
  (newline))

(define (show-label to-go this-col-number)
  (cond ((= to-go 0) '())
	(else
	 (display "  -----")
	 (display (number->letter this-col-number))
	 (display "----")
	 (show-label (- to-go 1) (+ 1 this-col-number)))))

(define (show-rows to-go col row)
  (cond ((= to-go 0) 'done)
	(else
	 (display (align row 2 0))
	 (display " ")
	 (show-row 6 col row)
	 (newline)
	 (show-rows (- to-go 1) col (+ row 1)))))

(define (show-row to-go col row)
  (cond ((= to-go 0) 'done)
	(else
	   (display (if (selected-indices? col row) ">" " "))
	   (display-value (cell-value-from-indices col row))
	   (display (if (selected-indices? col row) "<" " "))
	   (show-row (- to-go 1) (+ 1 col) row))))

(define (selected-indices? col row)
  (and (= col (id-column (selection-cell-id)))
       (= row (id-row (selection-cell-id)))))

(define (display-value val)
  (display (align (if (null? val) "" val) 10 2)))

(define (display-expression expr)
  (cond ((null? expr) (display '()))
	((quoted? expr) (display (quoted-value expr)))
	((word? expr) (display expr))
	((id? expr)
	 (display-cell-name expr))
	(else (display-invocation expr))))

(define (display-invocation expr)
  (display "(")
  (display-expression (car expr))
  (for-each (lambda (subexpr)
	      (display " ")
	      (display-expression subexpr))
	    (cdr expr))
  (display ")"))
      

;;; Abstract Data Types

;; Special cells: the selected cell and the screen corner

(define *special-cells* (make-vector 2))

(define (selection-cell-id)
  (vector-ref *special-cells* 0))

(define (set-selection-cell-id! new-id)
  (vector-set! *special-cells* 0 new-id))

(define (screen-corner-cell-id)
  (vector-ref *special-cells* 1))

(define (set-screen-corner-cell-id! new-id)
  (vector-set! *special-cells* 1 new-id))


;; Cell names

(define (cell-name? expr)
  (and (word? expr)
       (letter? (first expr))
       (number? (bf expr))))

(define (cell-name-column cell-name)
  (letter->number (first cell-name)))

(define (cell-name-row cell-name)
  (bf cell-name))

(define (cell-name->id cell-name)
  (make-id (cell-name-column cell-name)
	   (cell-name-row cell-name)))
	
;; Cell IDs

(define (make-id col row)
  (list 'id col row))

(define (id-column id)
  (cadr id))

(define (id-row id)
  (caddr id))

(define (id? x)
  (and (list? x)
       (not (null? x))
       (equal? 'id (car x))))

;; Cells

(define (make-cell)
  (vector '() '() '() '()))

(define (cell-value id)
  (vector-ref (cell-structure id) 0))

(define (cell-value-from-indices col row)
  (vector-ref (cell-structure-from-indices col row) 0))

(define (cell-expr id)
  (vector-ref (cell-structure id) 1))

(define (cell-parents id)
  (vector-ref (cell-structure id) 2))

(define (cell-children id)
  (vector-ref (cell-structure id) 3))

(define (set-cell-value! id val)
  (vector-set! (cell-structure id) 0 val))

(define (set-cell-expr! id val)
  (vector-set! (cell-structure id) 1 val))

(define (set-cell-parents! id val)
  (vector-set! (cell-structure id) 2 val))

(define (set-cell-children! id val)
  (vector-set! (cell-structure id) 3 val))

(define (cell-structure id)
  (global-array-lookup (id-column id)
		       (id-row id)))

(define (cell-structure-from-indices col row)
  (global-array-lookup col row))

(define *the-spreadsheet-array* (make-vector 30))

(define (global-array-lookup col row)
  (if (and (<= row 30) (<= col 26))
      (vector-ref (vector-ref *the-spreadsheet-array* (- row 1))
		  (- col 1))
      (error "Out of bounds")))

(define (init-array)
  (fill-array-with-rows 29))

(define (fill-array-with-rows n)
  (if (< n 0)
      'done
      (begin (vector-set! *the-spreadsheet-array* n (make-vector 26))
	     (fill-row-with-cells
	      (vector-ref *the-spreadsheet-array* n) 25)
	     (fill-array-with-rows (- n 1)))))

(define (fill-row-with-cells vec n)
  (if (< n 0)
      'done
      (begin (vector-set! vec n (make-cell))
	     (fill-row-with-cells vec (- n 1)))))

;;; Utility Functions

(define alphabet
  '#(a b c d e f g h i j k l m n o p q r s t u v w x y z))

(define (letter? something)
  (and (word? something)
       (= 1 (count something))
       (vector-member something alphabet)))

(define (number->letter num)
  (vector-ref alphabet (- num 1)))

(define (letter->number letter)
  (+ (vector-member letter alphabet) 1))

(define (vector-member thing vector)
  (vector-member-helper thing vector 0))

(define (vector-member-helper thing vector index)
  (cond ((= index (vector-length vector)) #f)
	((equal? thing (vector-ref vector index)) index)
	(else (vector-member-helper thing vector (+ 1 index)))))

(define (remdup lst)
  (cond ((null? lst) '())
	((member (car lst) (cdr lst))
	 (remdup (cdr lst)))
	(else (cons (car lst) (remdup (cdr lst))))))

(define (remove bad-item lst)
  (filter (lambda (item) (not (equal? item bad-item)))
	  lst))
