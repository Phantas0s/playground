; This is a Swing-based game where the arrow keys to guide
; a snake to apples.  Each time the snake eats an apple it
; grows and a new apple appears in a random location.
; If the head of the snake hits its body, you lose.
; If the snake grows to a length of 10, you win.
; In either case the game starts over with a new, baby snake.
;
; This was originally written by Abhishek Reddy.
; Mark Volkmann rewrote it in an attempt to make it easier to understand.

; source http://java.ociweb.com/mark/programming/ClojureSnake.html

(ns com.ociweb.snake
  (:import
   (java.awt Color Dimension)
   (java.awt.event KeyListener)
   (javax.swing JFrame JOptionPane JPanel))
  (:use clojure.contrib.import-static))

(import-static java.awt.event.KeyEvent VK_LEFT VK_RIGHT VK_UP VK_DOWN)

(defstruct cell-struct :x :y)
(defstruct snake-struct :body :direction)
(defstruct game-struct
  :panel :cell-size :length-to-win :ms-per-move :apple :snake)

(defn board-dimensions [panel cell-size]
  (let [size (.getPreferredSize panel)]
    [(quot (.getWidth size) cell-size)
     (quot (.getHeight size) cell-size)]))

(defn create-center-cell [width height]
  (struct cell-struct (quot width 2) (quot height 2)))

(defn create-random-cell [width height]
  (struct cell-struct (rand-int (- width 1)) (rand-int (- height 1))))

(defn create-snake [width height]
  (let [head (create-center-cell width height)
        body (list head)]
    (struct snake-struct body :right)))

(defn create-game [panel cell-size]
  (let [length-to-win 10
        ms-per-move 50
        [width height] (board-dimensions panel cell-size)
        apple (create-random-cell width height)
        snake (create-snake width height)]
    (struct game-struct
            panel cell-size length-to-win ms-per-move apple snake)))

(defn paint-cell [panel color cell-size {x :x y :y}]
  (let [graphics (.getGraphics panel)]
    (.setColor graphics color)
    (.fillRect graphics
               (* x cell-size) (* y cell-size) cell-size cell-size)))

(defn erase-cell [game cell]
  (let [panel (game :panel)
        color (.getBackground panel)
        cell-size (game :cell-size)]
    (paint-cell panel color cell-size cell)))

(defn erase-apple [game]
  (let [apple (game :apple)]
    (erase-cell game apple)))

(defn erase-snake [game]
  (doseq [cell ((game :snake) :body)]
    (erase-cell game cell)))

(defn paint-apple [panel cell-size apple]
  (paint-cell panel Color/RED cell-size apple))

(defn paint-snake [panel cell-size snake]
  ; We only need to paint the head because
  ; the rest will have been already painted.
  (let [head (first (snake :body))]
    (paint-cell panel Color/GREEN cell-size head)))

(defn paint-game [game]
  (let [panel (game :panel)
        cell-size (game :cell-size)]
    (paint-apple panel cell-size (game :apple))
    (paint-snake panel cell-size (game :snake))))

(defn new-apple [game]
  (let [panel (game :panel)
        cell-size (game :cell-size)
        [width height] (board-dimensions panel cell-size)]
    (erase-apple game)
    (create-random-cell width height)))

(defn delta
  "Gets a vector containing dx and dy values for a given direction."
  [direction]
  (direction {:left [-1 0], :right [1 0], :up [0 -1], :down [0 1]}))

(defn new-direction
  "Returns the snake's direction, either the current direction
   or a new one if a board edge was reached."
  [game]
  (let [snake (game :snake)
        direction (snake :direction)
        head (first (snake :body))
        x (head :x)
        y (head :y)
        panel (game :panel)
        cell-size (game :cell-size)
        [width height] (board-dimensions panel cell-size)
        at-left (= x 0)
        at-right (= x (- width 1))
        at-top (= y 0)
        at-bottom (= y (- height 1))]
    ; Turn clockwise when a board edge is reached
    ; unless that would result in going off the board.
    (cond
      (and (= direction :up) at-top) (if at-right :left :right)
      (and (= direction :right) at-right) (if at-bottom :up :down)
      (and (= direction :down) at-bottom) (if at-left :right :left)
      (and (= direction :left) at-left) (if at-top :down :up)
      true direction)))

(defn same-or-adjacent-cell? [cell1 cell2]
  (let [dx (Math/abs (- (cell1 :x) (cell2 :x)))
        dy (Math/abs (- (cell1 :y) (cell2 :y)))]
    (and (<= dx 1) (<= dy 1))))

(defn eat-apple? [game]
  (let [apple (game :apple)
        snake (game :snake)
        head (first (snake :body))]
    (same-or-adjacent-cell? head apple)))

(defn remove-tail [game body]
  (let [tail (last body)]
    (erase-cell game tail)
    (butlast body)))

(defn move-snake [game grow]
  "Moves the snake and returns a new snake-struct.
   The snake grows it by one cell if 'grow' is true."
  (let [direction (new-direction game)
        [dx dy] (delta direction)
        snake (game :snake)
        body (snake :body)
        head (first body)
        x (head :x)
        y (head :y)
        new-head (struct cell-struct (+ x dx) (+ y dy))
        body (cons new-head body)
        body (if grow body (remove-tail game body))]
    (struct snake-struct body direction)))

(defn get-key-direction
  "Gets a keyword that describes the direction
   associated with a given key code."
  [key-code]
  (cond
    (= key-code VK_LEFT) :left
    (= key-code VK_RIGHT) :right
    (= key-code VK_UP) :up
    (= key-code VK_DOWN) :down
    true nil))

(defn snake-with-key-direction [snake key-code-atom]
  (let [key-code @key-code-atom
        key-direction (get-key-direction key-code)
        current (snake :direction)
        ; Don't let the snake double back on itself.
        valid-change (cond
                       (= key-direction nil) false
                       (= key-direction :left) (not= current :right)
                       (= key-direction :right) (not= current :left)
                       (= key-direction :up) (not= current :down)
                       (= key-direction :down) (not= current :up)
                       true true)]
    (if valid-change
      (do
        (compare-and-set! key-code-atom key-code nil)
        (assoc snake :direction key-direction))
      snake)))

(defn head-overlaps-body? [body]
  (let [head (first body)]
    (some #(= % head) (rest body))))

(defn restart-game [game]
  (erase-apple game)
  (erase-snake game)
  (create-game (game :panel) (game :cell-size)))

(defn new-game [game message]
  (let [panel (game :panel)
        top (.getTopLevelAncestor panel)]
    (JOptionPane/showMessageDialog top message)
    (restart-game game)))

(defn win? [game]
  (let [snake (game :snake)
        body (snake :body)]
    (= (count body) (game :length-to-win))))

(defn lose? [game]
  (let [snake (game :snake)
        body (snake :body)]
    (head-overlaps-body? body)))

(defn step [game key-code-atom]
  (let [eat (eat-apple? game)
        snake (snake-with-key-direction (game :snake) key-code-atom)
        game (assoc game :snake snake)
        game (if eat (assoc game :apple (new-apple game)) game)
        snake (move-snake game eat)]
    (cond
      (lose? game) (new-game game "You killed the snake!")
      (win? game) (new-game game "You win!")
      true (assoc game :snake snake))))

(defn create-panel [width height key-code-atom]
  (proxy [JPanel KeyListener]
         [] ; superclass constructor arguments
    (getPreferredSize [] (Dimension. width height))
    (keyPressed [e]
      (compare-and-set! key-code-atom @key-code-atom (.getKeyCode e)))
    (keyReleased [e]) ; do nothing
    (keyTyped [e]) ; do nothing
    ))

(defn configure-gui [frame panel]
  (doto panel
    (.setFocusable true) ; won't generate key events without this
    (.addKeyListener panel))
  (doto frame
    (.add panel)
    (.pack)
    (.setDefaultCloseOperation JFrame/EXIT_ON_CLOSE)
    (.setVisible true)))

(defn main []
  (let [frame (JFrame. "Snake")
        width 30
        height 30
        cell-size 10
        key-code-atom (atom nil)
        panel-width (* width cell-size)
        panel-height (* height cell-size)
        panel (create-panel panel-width panel-height key-code-atom)
        first-game (create-game panel cell-size)]
    (configure-gui frame panel)
    (loop [game first-game]
      (paint-game game)
      (Thread/sleep (game :ms-per-move))
      (recur (step game key-code-atom)))))

; Only run the application if this is being run as a script,
; not if loaded in a REPL with load-file.
; When run as a script, the path to this file
; will be a command-line argument.
(if *command-line-args* (main))

