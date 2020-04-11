; Pure functions are referentially transparent

; referentially transparent
; only use argument + immutable value (" Daniel-san")
(defn wisdom
  [words]
  (str words ", Danial-san"))
(wisdom "Always bathe on Fridays")

; not referentially transparent
(defn analyze-file
  [filename]
  (analysis (slurp filename)))

; referentially transparent
(defn analysis
  [text]
  (str "Character count: " (count text)))

; Recursions
; Can't associate a value with a name without creating a new scope

(def great-baby-name "Rosanthony")
great-baby-name

(let [great-baby-name "Bloodthunder"]
  great-baby-name)
; => "Bloodthunder"
great-baby-name
; => "Rosanthony"

; general approach to recursive problem solving

(rest [1 2 3 4]) ; => (2 3 4)
(defn sum
  ([vals] (sum vals 0))
  ([vals accumulating-total]
   (if (empty? vals)
     accumulating-total
     (sum (rest vals) (+ (first vals) accumulating-total)))))

; (sum [39 5 1])  single-arity body calls two-arity body
; (sum [39 5 1] 0)
; (sum [5 1] 39)
; (sum [1] 44)
; (sum [] 45)  base case is reached, so return accumulating-total
; => 45

; It's more efficient to use recur

(defn sum
  ([vals] (sum vals 0))
  ([vals accumulating-total]
   (if (empty? vals)
     accumulating-total
     (recur (rest vals) (+ (first vals) accumulating-total)))))
(sum [1 2 3 4]) ; => 10

; Ruby
; class GlamourShotCaption
;   attr_reader :text
;   def initialize(text)
;     @text = text
;     clean!
;   end

;   private
;   def clean!
;     text.trim!
;     text.gsub!(/lol/, "LOL")
;   end
; end

; best = GlamourShotCaption.new("My boa constrictor is so sassy lol!  ")
; best.text
; ; => "My boa constrictor is so sassy LOL!"


(require '[clojure.string :as s])
(defn clean
  [text]
  (s/replace (s/trim text) #"lol" "LOL"))

(clean "My boa constrictor is so sassy lol!   ")

; other way using reducing over function
(defn clean'
  [text]
  (reduce (fn [string string-fn] (string-fn string))
          text
          [s/trim #(s/replace % #"lol" "LOL")]))
(clean' "My boa constrictor is so sassy lol!   ")

; comp

((comp inc *) 2 3)
(inc (* 2 3))
; => 7

; role playing game character

(def character
  {:name "Smooches McCutes"
   :attributes {:intelligence 10
                :strength 4
                :dexterity 5}})
(def c-int (comp :intelligence :attributes))
(def c-str (comp :strength :attributes))
(def c-dex (comp :dexterity :attributes))

(c-int character)
(c-str character)
(c-dex character)

(int 1.5) ; => 1

(defn spell-slots
  [char]
  (int (inc (/ (c-int char) 2))))
(spell-slots character)

; same thing with comp with function accepting two arguments
(def spell-slots-comp (comp int inc #(/ % 2) c-int))
(spell-slots-comp character)

(defn two-comp
  [f g]
  (fn [& args]
    (f (apply g args))))

; memoize

(defn sleepy-identity
  "Returns the given value after 1 second"
  [x]
  (Thread/sleep 1000)
  x)
(sleepy-identity "Mr. Fantastico")
; => "Mr. Fantastico" after one second
(sleepy-identity "Mr. Fantastico")
; => "Mr. Fantastico" after one second

(def memo-sleepy-identity (memoize sleepy-identity))
(memo-sleepy-identity "Mr. Fantastico")
; => "Mr. Fantastico" after one second
(memo-sleepy-identity "Mr.Fantastico")
; => "Mr. Fantastico" immediately
(memo-sleepy-identity "Mrs.Fantastica")
; => "Mrs. Fantastica" after one second

; Exercises

; 1. You used (comp :intelligence :attributes) to create a function that returns a character’s intelligence.
; Create a new function, attr, that you can call like (attr :intelligence) and that does the same thing.

(def character
  {:name "Smooches McCutes"
   :attributes {:intelligence 10
                :strength 4
                :dexterity 5}})
(def c-int (comp :intelligence :attributes))
(def c-str (comp :strength :attributes))
(def c-dex (comp :dexterity :attributes))

(c-int character)
(c-str character)
(c-dex character)

(defn attr
  [attribute]
  (get-in character [:attributes attribute]))

(attr :intelligence)

; 2.Implement the comp function.

; try to reimplement clojure comp?
(defn two-comp
  [f g]
  (fn [& args]
    (f (apply g args))))

((two-comp inc *) 2 3) ; => 7

; doesn't work
(defn my-comp
  ([]
   (fn [& args] args))
  ([& funcs]
   (fn [& args]
     (reduce (fn [a f] (apply f a)) args (reverse funcs)))))
((comp inc +) 1 2) ; => 4

; Only work with one argument (see https://commandercoriander.net/blog/2015/02/21/writing-clojures-comp-function-from-scratch/)

(defn my-comp
  [& all-fns]
  (loop [fns all-fns
         acc-fn identity]
    (if (empty? fns)
      acc-fn
      (recur (butlast fns) (fn [& a] ((last fns) (acc-fn a)))))))

((my-comp inc +) 1) ; => 2

; refactoring
(defn my-comp [& all-fns]
  (reduce
   (fn [acc-fn curr-fn]
     (fn [a]
       (acc-fn (curr-fn a))))
   identity
   all-fns))

; With multiple argument

(defn my-comp
  [& all-fns]
  (reduce
   (fn [acc-fn curr-fn]
     (fn [& args]
       (acc-fn (apply curr-fn args))))
   identity
   all-fns))

((my-comp inc +) 1 2)

; 3. Implement the assoc-in function. Hint: use the assoc function and define its parameters as [m [k & ks] v]

(defn my-assoc-in
  [res [k & ks] v]
  (if ks
    (assoc res k (my-assoc-in (get res k) ks v))
    (assoc res k v)))

; (assoc {} :cookie (my-assoc-in {} [:monster :vocals] "Finntroll"))
; (assoc {} :cookie (assoc {} :monster (my-assoc-in {} [:monster :vocals] "Finntroll")))
; (assoc {} :cookie (assoc {} :monster (assoc {} :vocals (my-assoc-in {} [:monster :vocals] "Finntroll"))))
; (assoc {} :cookie (assoc {} :monster (assoc {} :vocals "Finntroll")))
(assoc {} :cookie (assoc {} :monster (assoc {} :vocals "Finntroll")))

(assoc-in {} [:cookie :monster :vocals] "Finntroll")
(my-assoc-in {} [:cookie :monster :vocals] "Finntroll")

; 4. Look up and use the update-in function.

(def thing {:cookie {:monster {:age 29}}})
(update-in thing [:cookie :monster :age] inc)

; 5. Implement update-in.

(defn my-update-in
  [original path func]
  (assoc-in {} path (func (get-in original path))))

(def thing {:cookie {:monster {:age 29}}})
(my-update-in thing [:cookie :monster :age] inc)
