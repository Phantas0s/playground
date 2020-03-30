; Use the list function, quoting, and read-string to create a list that, when evaluated, prints your first name and your favorite sci-fi movie.Use the list function, quoting, and read-string to create a list that, when evaluated, prints your first name and your favorite sci-fi movie.

(eval (read-string "(list 'Matthieu 'Alien))"))
'( 2 3)

; Create an infix function that takes a list like (1 + 3 * 4 - 5) and transforms it into the lists that Clojure needs in order to correctly evaluate the expression using operator precedence rules.

; TODO doesn't work for 3 * 2 * 5 (when * or / signs are one after the other)
; TODO doesn't work for 3 * 2 + 5 either (2 twice)
; TODO DOESNT WOOOORRKKK
(defn first-priority [infixed]
  (loop [new-list [] 
         list-index 0
         current-val (first infixed)]
      ; (println list-index)
      (println new-list)
      (println current-val)
      (cond  
        (>= list-index (count infixed)) (seq new-list)
        (or (= current-val '*) (= current-val '/)) (recur (into (vec (butlast new-list)) [(list current-val (nth new-list (dec list-index)) (nth infixed (inc list-index)))]) (+ list-index 1) (nth infixed (+ list-index 1)))
        (and (list? (last new-list)) (number? current-val)) (recur new-list (+ list-index 1) (nth infixed (+ list-index 1) false))
        :else (recur (into new-list [current-val]) (inc list-index) (nth infixed (inc list-index) list-index))
        )))

(first-priority '(1 + 3 * 2 * 5))
(first-priority '(1 + 3 * 2 + 5))

; (defmacro infix
;   [infixed]

;   (loop [])
;   )
