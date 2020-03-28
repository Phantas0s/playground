; Use the list function, quoting, and read-string to create a list that, when evaluated, prints your first name and your favorite sci-fi movie.Use the list function, quoting, and read-string to create a list that, when evaluated, prints your first name and your favorite sci-fi movie.

(eval (read-string "(list 'Matthieu 'Alien))"))
'( 2 3)

; Create an infix function that takes a list like (1 + 3 * 4 - 5) and transforms it into the lists that Clojure needs in order to correctly evaluate the expression using operator precedence rules.
(defmacro first-priority [infixed]
  (loop [base infixed
         new-list ()
         list-index 0
         current-val (first infixed)]
    (let [next-val (nth infixed (inc list-index))
          prev-val (nth infixed (dec list-index))]
      (cond  
        (= list-index (count (- new-list 1))) (new-list)
        (or (= current-val "*") ( current-val "/")) (recur base (conj new-list (list current-val prev-val next-val)) (inc list-index) (nth infixed (inc list-index))) 
        :else (recur base (conj new-list current-val) (inc list-index) (nth infixed (inc list-index)))
        ))))

(first-priority (1 + 3 * 2 - 5))

; (defmacro infix
;   [infixed]

;   (loop [])
;   )
