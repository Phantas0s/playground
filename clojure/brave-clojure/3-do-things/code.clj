; Need to run the repl from ../1-building-running-REPL/clojure-noob and then execute the code from there

(+ 1 2 3)
(str "hello " " I'm " " here")

(if true
  "By Zeus's hammer!" ; then
  "By Aquaman's trident!") ; else

(if false
  "By Zeus's hammer!"
  "By Aquaman's trident!")

(if false
  "By Zeus's hammer!")
; => nil

; Multiple line for then and else - do
(if true
  (do (println "Success!")
      "By Zeus's hammer!")
  (do (println "Failure!")
      "By Aquaman's Triden!"))

; when: if + do without else branches
(when true
  (println "success")
  "Abra cadabra!")

(nil? 1)
(nil? nil)

(if "bears eat beets"
  "bears beets Battelstar Galactica")

(if nil
  "This won't be the result because nil is falsey"
  "nil is falsey")

; equality operator
(= 1 1)
(= nil nil)
(= 1 2)
(= "1" 1) ;false
(= "1" "1") ;true

; or - return first true value or last value
(or false nil :large_I_mean_venti :why_cant_I_just_say_large) ;:large_I_mean_venti
(or (= 0 1) (= "yes" "no")) ;false
(or nil) ;nil

; and - return first false value or last value
(and :free_wifi :hot_coffee)
(and :feeling_super_cool nil false)

; def - bind name to value

(def failed-protagonist-names
  ["larry Potter" "Doreen the Explorer" "The Ravengers"]) ; vector containing three strings
failed-protagonist-names

; multiple assignment

(def severity :mild)
(def error-message "OH GOD! IT'S A DISASTER! WE'RE ")
(if (= severity :mild)
  (def error-message (str error-message "MIDLY INCONVENIENT"))
  (def error-message (str error-message "DOOOMEEEEEDDDDDDDDDD!!!!")))
(error-message)

; ... but you should not change name / value association

(defn error-message
  [severity]
  (str "OH GOD! IT'S A DISASTER! WE'RE "
       (if (= severity :mild)
         "MILDY INCONVENIENT"
         "DOOOOMMEEEEEDD!!!!!!!!")))
(error-message :mild)
(error-message :dangerous)

; numbers
89
1.2
1/20

; strings
"Lord Voldemore"
"\"He who must not be named\""
"\"Great cow of Moscow\" - Hermes Conrad"
; 'Lord Voldemore' -> not valid!

(def name "Chewbacca")
(str "\"Ugglglglglglglgllglgg\" - " name) ; only way to concatenate

; maps
; similar to dictionary / hash in other languages

{} ; empty map
{:first-name "Charlie"
 :last-name "McFishwich"}
{:string-key +} ;associate string-key with + function
{:name {:first "John" :middle "Jacob" :last "Jiglehetarington"}} ;nested maps

(hash-map :a 1 :b 2) ;other way to create a map
(get {:a 0 :b 1} :b) ;lookup value
(get {:a 0 :b {:c "ho hum"}} :b)

(get {:a 0 :b 1} :c) ;nil
(get {:a 0 :b 1} :c "unicorns?") ;unicorns?

(get-in {:a 0 :b {:c "hey hey!"}} [:b :c]) ;get value in nested map
({:name "The Human Coffeeport"} :name) ;treat map as function to get value
(:name {:name "The Human Coffeeport"})

; keywords

(:a {:a 1 :b 2 :c 3}) ;can be used as function to find value in map -> (get {:a 1 :b 2 :c 3} :a)
(:d {:a 1 :b 2 :c 3} "No gnome knows homes like Noah knows") ;with default value
; clojurist do that all the time!

; Vectors
[3 2 1]
(get [3 2 1] 0) ;=> 3
(get ["a" {:name "Puglsey Winterbottom"} "c"], 1)
(get-in ["a" {:name "Pugsley Winterbottom"}] [1 :name])
(vector "creepy" "full" "moon")
(conj [1 2 3] 4)

; Lists
'(1 2 3 4)
(nth '(1 2 3 4) 0) ;slower than using get on a vector
(nth '(:a :b :c) 0)

(list 1 "two" {3 4})
(conj '(2,3,4) 1)

; Hash sets
#{"Kurt Vonnegut" 20 :icicle}
(hash-set 1 1 2 2 3 4) ;#{1 4 3 2}
(set [1 2 3 3 4]) ;#{1 4 3 2}
(contains? [1 2 3 5] 4)
(contains? #{nil} nil) ;true
(:a #{:a :b})
(:a #{:b :c})
(get #{:a :b} :a)
(get #{:a nil} nil) ; always return nil even if it doesn't contain nil
(contains? #{:a nil} nil) ;really return if there is nil in the hash set

; functions
(or + -) ; => #<core$_PLUS_ clojure.core$_PLUS_@76dace31>)
; return the plus function

((or + -) 1 2 3) ; 6
((and (= 1 1) +) 1 2 3); 6
((first [+ 0]) 1 2 3); 6
(1 2 3 4) ;invalid! Number and strings are not functions

(inc 1.1)
(map inc [0 1 2 3 4]); (1 2 3 4 5) - this is not a vector returned!
(+ (inc 199) (/ 100 (- 7 2)))
(+ 200 (/ 100 (- 7 2)))
(+ 200 20)

; Function Calls, Macro Calls, and Special Forms
; Example: def, if

; Defining Functions

(defn too-enthusiastic  ;name
  "Return a cheer that might be too enthusiastic!"  ;docstring
  [name] ;parameter
  (str "OH. MY. GOD! " name " YOU ARE MOST DEFINITELY LIKE THE BEST MAN SLASH WOMAN EVER I LOVE YOU AND WE SHOULD RUN AWAY SOMEWHERE")) ;function body
(too-enthusiastic "Zelda")

; functions with different arities
(defn no-params ;0-arity function
  []
  "I take no parameters!")
(defn one-param ;1-arity
  [x]
  (str "I take one parameter: " x))
(defn two-params ;2-arity
  [x y]
  (str "Two parameters! That's nothing! Pah! I will smoosh them together to spite you! " x y))
(two-params "bim" "bam")

; multiple-arity function
(defn multi-arity
  ;; 3-arity arguments and body
  ([first-arg second-arg third-arg]
   (do-things first-arg second-arg third-arg))
   ;; 2-arity arguments and body
  ([first-arg second-arg]
   (do-things first-arg second-arg))
   ;; 1-arity arguments and body
  ([first-arg]
   (do-things first-arg)))

; way of giving one argument a default value
(defn x-chop
  "Describe the kind of chop you're inflicting on someone"
  ([name chop-type]
   (str "I " chop-type " chop " name "! Take that!"))
  ([name]
   (x-chop name "karate")))
(x-chop "zelda")

(defn weird-arity
  ([]
   "Hello!")
  ([number]
   (inc number)))
(weird-arity)
(weird-arity 1)
; don't write a function like that! A bit confusing...

; rest parameter
(defn codger-communication
  [whippersnapper]
  (str "Get off my lawn, " whippersnapper "!!!"))

(defn codger
  [& whippersnappers] ;arguments traited as a list
  (map codger-communication whippersnappers))
(codger "billy" "Anne Marie" "The Incredible Hulk")

(defn favorite-things
  [name & things]
  (str "Hi, " name ", here are my favorite things: "
       (clojure.string/join ", " things)))

(favorite-things "Doreen" "gum"  "shoes" "kara-te")

; destructuring

(defn my-first
  [[first-thing]]
  first-thing)

(my-first ["oven" "bike" "war-axe"])

(defn chooser
  [[first-choice second-choice & unimportant-choices]]
  (println (str "Your first choice is: " first-choice))
  (println (str "Your second choice is: " second-choice))
  (println (str "We're ignoring the rest: "
                (clojure.string/join ", " unimportant-choices))))
(chooser ["Mamelade" "Handsome Jack" "Pigpen" "Aquamen" "IronMan"])

; destructure maps

(defn announce-treasure-location
  [{lat :lat lng :lng}] ; associate the value lat to the key :lat of the map
  (println (str "Treasure lag: " lat))
  (println (str "Treasure lng " lng)))
(announce-treasure-location {:lat 28.22 :lng 81.33})

; other syntax than previous example
(defn announce-treasure-location
  [{:keys [lat lng]}]
  (println (str "Treasure lat: " lat))
  (println (str "Treasure lng: " lng)))
(announce-treasure-location {:lat 28.22 :lng 81.33})

; function body

(defn illustrative-function
  []
  (+ 1 304)
  30
  "joe")
(illustrative-function); => joe

(defn number-comment
  [x]
  (if (> x 6)
    "Oh my gosh! What a big number!"
    "That number's OK, I guess?"))
(number-comment 5)
(number-comment 7)

; Anonymous functions

(map (fn [name] (str "Hi, " name))
     ["Darth Vader" "Mr. Magoo"])

((fn [x] (* x 3)) 8)

(def my-special-multiplier
  (fn [x] (* x 3)))
(my-special-multiplier 12)

; anonymous function: other syntax thanks to reader macros
#(* % 3)
(#(* % 3) 8) ; => 24

(map #(str "Hi, " %)
     ["Darth Vader" "Mr. Magoo"])

(#(str %1 " and " %2) "cornbread" "butter beans")

(#(identity %&) 1 "blarg" :yip) ; rest parameter

(defn inc-maker
  "Create a custom incrementator"
  [inc-by]
  #(+ % inc-by))

(def inc3 (inc-maker 3))
(inc3 7)
