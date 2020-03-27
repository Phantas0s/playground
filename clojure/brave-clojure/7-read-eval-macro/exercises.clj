; Use the list function, quoting, and read-string to create a list that, when evaluated, prints your first name and your favorite sci-fi movie.Use the list function, quoting, and read-string to create a list that, when evaluated, prints your first name and your favorite sci-fi movie.

(eval (read-string "(list 'Matthieu 'Alien))"))
'( 2 3)

; Create an infix function that takes a list like (1 + 3 * 4 - 5) and transforms it into the lists that Clojure needs in order to correctly evaluate the expression using operator precedence rules.

(defmacro infix
  [infixed]
  ())
