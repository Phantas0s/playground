; see https://github.com/flyingmachine/pegthing/blob/master/src/pegthing/core.clj
; prompt-row bootstrap the game

; Impossible to do more than 6 rows (no enough letters in the alphabet)

; (***********)
; (* GENERAL *)
; (***********)

; Peg Thing

; Four tasks to handle:
; 1. Creating a new board
; 2. Returning a board with the result of the player’s move
; 3. Representing a board textually
; 4. Handling user interaction


; Top layer: handling user interaction - produce all program side effects
; Bottom layer: don't use the top layer at all

; Each function does one small, understandable task
; Name each substack - better express the intention of the code

; (*********)
; (* BOARD *)
; (*********)

; Displayed board

; All position pegged

; 
;      a0
;     b0 c0
;   d0 e0 f0
;  g0 h0 i0 j0
;k0 l0 m0 n0 o0

; e position not pegged

; 
;      a0
;     b0 c0
;   d0 e- f0
;  g0 h0 i0 j0
;k0 l0 m0 n0 o0

; Internal board

;      01
;     02 03
;    04 05 06
;   07 08 09 10
; 11 12 13 14 15

(ns peg-thing.core
  (:gen-class))

(declare successful-move prompt-move game-over query-rows)

; Representation of the board

; :connections {6 3, 4 2}
; key: legal destination
; value: position that would be jumped over
; Example: peg 1 can jump position 6 to toposition 3

; {1 {:pegged true, :connections {6 3, 4 2}}
;  2 {:pegged true, :connections {9 5, 7 4}}
;  3  {:pegged true, :connections {10 6, 8 5}}
;  4  {:pegged true, :connections {13 8, 11 7, 6 5, 1 2}}
;  5  {:pegged true, :connections {14 9, 12 8}}
;  6  {:pegged true, :connections {15 10, 13 9, 4 5, 1 3}}
;  7  {:pegged true, :connections {9 8, 2 4}}
;  8  {:pegged true, :connections {10 9, 3 5}}
;  9  {:pegged true, :connections {7 8, 2 5}}
;  10 {:pegged true, :connections {8 9, 3 6}}
;  11 {:pegged true, :connections {13 12, 4 7}}
;  12 {:pegged true, :connections {14 13, 5 8}}
;  13 {:pegged true, :connections {15 14, 11 12, 6 9, 4 8}}
;  14 {:pegged true, :connections {12 13, 5 9}}
;  15 {:pegged true, :connections {13 14, 6 10}}
;  :rows 5}

(defn tri*
  "Generates lazy sequence of triangular numbers"
  ([] (tri* 0 1))
  ([sum n]
   (let [new-sum (+ sum n)]
     (cons new-sum (lazy-seq (tri* new-sum (inc n)))))))

; create the lazy sequence
(def tri (tri*))
(take 5 tri)

(defn triangular?
  "Is the number triangular? e.g 1, 3, 6, 10, 15..."
  [n]
  (= n (last (take-while #(>= n %) tri))))
(triangular? 5)
; => false

(defn row-tri
  "The triangular number at the end of the row n"
  [n]
  (last (take n tri)))
(row-tri 1)
; => 1
(row-tri 2)
; => 3
(row-tri 2938)

(defn row-num
  "Returns row number the position belongs to: pos 1 in row 1,
  positions 2 and 3 in row 2..."
  [pos]
  (inc (count (take-while #(> pos %) tri))))
(row-num 1)
; => 1
(row-num 5)
; => 3

(defn connect
  "Form a mutual connection between two positions"
  [board max-pos pos neighbor destination]
  (if (<= destination max-pos)
    (reduce (fn [new-board [p1 p2]]
              (assoc-in new-board [p1 :connections p2] neighbor))
            board
            [[pos destination] [destination pos]])
    board))
(connect {} 15 1 2 4)

(defn connect-right
  [board max-pos pos]
  (let [neighbor (inc pos)
        destination (inc neighbor)]
    (if-not (or (triangular? neighbor) (triangular? pos))
      (connect board max-pos pos neighbor destination)
      board)))

(defn connect-down-left
  [board max-pos pos]
  (let [row (row-num pos)
        neighbor (+ row pos)
        destination (+ 1 row neighbor)]
    (connect board max-pos pos neighbor destination)))

(defn connect-down-right
  [board max-pos pos]
  (let [row (row-num pos)
        neighbor (+ 1 row pos)
        destination (+ 2 row neighbor)]
    (connect board max-pos pos neighbor destination)))

(connect-down-left {} 15 1)
; => {1 {:connections {4 2}
;     4 {:connections {1 2}}}} - No need to connect-up, already done here for peg 4

(connect-down-right {} 15 3)
; => {3  {:connections {10 6}}
;     10 {:connections {3 6}}}

(defn add-pos
  "Pegs the position and performs connections"
  [board max-pos pos]
  (let [pegged-board (assoc-in board [pos :pegged] true)]
    (reduce (fn [new-board connection-creation-fn]
              (connection-creation-fn new-board max-pos pos))
            pegged-board
            [connect-right connect-down-left connect-down-right])))
(add-pos {} 15 1)

(defn new-board
  "Creates a new board with the given number of rows"
  [rows]
  (let [initial-board {:rows rows}
        max-pos (row-tri rows)]
    (reduce (fn [board pos] (add-pos board max-pos pos))
            initial-board
            (range 1 (inc max-pos)))))
(new-board 5)

; (***************)
; (* MOVING PEGS *)
; (***************)

(defn pegged?
  "does the position have a peg in it?"
  [board pos]
  (get-in board [pos :pegged]))

(defn remove-peg
  "Take the peg at given position out of the board"
  [board pos]
  (assoc-in board [pos :pegged] false))

(defn place-peg
  "Put a prg in the board at given position"
  [board pos]
  (assoc-in board [pos :pegged] true))

(defn move-peg
  "Take peg out of p1 and place it in p2"
  [board p1 p2]
  (place-peg (remove-peg board p1) p2))

(defn valid-moves
  "Return a map of all valid moves for pos, where the key is the
  destination and the value is the jumped position"
  [board pos]
  (into {}
        (filter (fn [[destination jumped]]
                  (and (not (pegged? board destination))
                       (pegged? board jumped)))
                (get-in board [pos :connections]))))

; Example
(def my-board (assoc-in (new-board 5) [4 :pegged] false))
; 
;      a0
;     b0 c0
;   d- e0 f0
;  g0 h0 i0 j0
;k0 l0 m0 n0 o0
(valid-moves my-board 1) ; => {4 2}
(valid-moves my-board 6) ; => {4 5}
(valid-moves my-board 8)  ; => {}

(defn valid-move?
  "Return jumped position if the move from p1 to p2 is valid, nil
  otherwise"
  [board p1 p2]
  (get (valid-moves board p1) p2))

(valid-move? my-board 8 4) ; => nil
(valid-move? my-board 1 4) ; => 2

(defn make-move
  "Move peg from p1 to p2, removing jumped peg"
  [board p1 p2]
  (if-let [jumped (valid-move? board p1 p2)]
    (move-peg (remove-peg board jumped) p1 p2)))

(if-let [test (nil? nil)]
  (str "nil is nil! This is so " test)
  "nis is not nil")

(defn can-move?   ; function which end with ? is a predicate function
  "Do any of the pegged positions have vaid moves?"
  [board]
  (some (comp not-empty (partial valid-moves board))
        (map first (filter #(get (second %) :pegged) board))))

; (************************************)
; (* RENDERING AND PRINTING THE BOARD *)
; (************************************)

(def alpha-start 97)
(def alpha-end 123)
(def letters (map (comp str char) (range alpha-start alpha-end)))
(def pos-chars 3)

(defn render-pos
  [board pos]
  (str (nth letters (dec pos))
       (if (get-in board [pos :pegged])
         (str "0")
         (str "-"))))

(defn row-positions
  "Return all positions in the given row"
  [row-num]
  (range (inc (or (row-tri (dec row-num)) 0))
         (inc (row-tri row-num))))

(defn row-padding
  "String of spaces to add to the beginning of a row to center it"
  [row-num rows]
  (let [pad-length (/ (* (- rows row-num) pos-chars) 2)]
    (apply str (take pad-length (repeat " ")))))

(defn render-row
  [board row-num]
  (str (row-padding row-num (:rows board))
       (clojure.string/join " " (map (partial render-pos board)
                                     (row-positions row-num)))))

(defn print-board
  [board]
  (doseq [row-num (range 1 (inc (:rows board)))]
    (println (render-row board row-num))))

; (**********************)
; (* PLAYER INTERACTION *)
; (**********************)

(defn letter->pos
  "Converts a letter string to the corresponding position number"
  [letter]
  (inc (- (int (first letter)) alpha-start)))

(defn get-input
  "Waits for user to enter text and hit enter, then cleans the input"
  ([] (get-input nil))
  ([default]
   (let [input (clojure.string/trim (read-line))]
     (if (empty? input)
       default
       (clojure.string/lower-case input)))))

(defn characters-as-strings
  "Given a string, return a collection consisting of each individual character"
  [string]
  (re-seq #"[a-zA-Z]" string))
(characters-as-strings "a     b")
(characters-as-strings "a     cb")

(defn user-entered-invalid-move
  "Handles the next step after a user has entered an invalid move"
  [board]
  (println "\n!!! That was an invalid move :'(\n")
  (prompt-move board))

(defn user-entered-valid-move
  "Handles the next step after a user has entered a valid move"
  [board]
  (if (can-move? board)
    (prompt-move board)
    (game-over board)))

(defn prompt-move
  [board]
  (println "\nHere's your board:")
  (print-board board)
  (println "Move from where to where? Enter two letters:")
  (let [input (map letter->pos (characters-as-strings (get-input)))]
    (if-let [new-board (make-move board (first input) (second input))]
      (user-entered-valid-move new-board)
      (user-entered-invalid-move board))))

(defn prompt-empty-peg
  [board]
  (println "Here's your board:")
  (print-board board)
  (println "Remove which peg [e]")
  (prompt-move (remove-peg board (letter->pos (get-input "e")))))

(defn prompt-rows
  []
  (println "How many rows? [5]")
  (let [rows (Integer. (get-input 5))
        board (new-board rows)]
    (prompt-empty-peg board)))

(defn game-over
  "Announce the game is over and prompt to play again"
  [board]
  (let [remaining-pegs (count (filter :pegged (vals board)))]
    (println "Game over! You had" remaining-pegs "pegs left:")
    (print-board board)
    (println "Play again? y/n [y]")
    (let [input (get-input "y")]
      (if (= "y" input)
        (prompt-rows)
        (do
          (println "Bye!")
          (System/exit 0))))))
(vals {:vampire 1 :human 2}) ; => (1 2)


; Exercises

1. You used (comp :intelligence :attributes) to create a function that returns a character’s intelligence.
Create a new function, attr, that you can call like (attr :intelligence) and that does the same thing.
