(defmacro backwards
  [form]
  (reverse form))

(backwards (" backwards" " am" "I" str))

; Evaluation of clojure list
(def addition-list (list + 1 2))
(eval addition-list)
; => 3

(eval (concat addition-list [10]))
; => 13

(eval (list 'def 'lucky-number (concat addition-list [10])))
lucky-number
; => 13

; READER

; simple reader forms
(read-string "(+ 1 2)")
; => (+ 1 2)

(list? (read-string "(+ 1 2)"))
; true

(conj (read-string "(+ 1 2)") :zagglewag)
; => (:zagglewag + 1 2)

(eval (read-string "(+ 1 2)"))
; => 3

; more complex reader form
(read-string "#(+ 1 %)")
; => (fn* [p1__423#] (+ 1 p1__423#))

; EVALUATOR

(def x 15)
(+ x 5)
; => 20 

(def x 15)
(let [x 5]
(+ x 8))
; => 13

; Nested binding

(let [x 5]
  (let [x 10]
    (+ x 10))
  )
; => 20


; map symbol is still a data structure
; mapping to the function map
(map inc [1 2 3])
; => (2 3 4)

; Only interacting with + symbol, not the addition function it refers to
(read-string "+")
; => +
(type (read-string "+"))
; => clojure.lang.Symbol
(list (read-string "+") 1 2)
; => (+ 1 2)

; Now the function is used
(eval (list (read-string "+") 1 2))
; => 3


