; data structure implements the sequence abstraction

(defn titleize
  "Example"
  [topic]
  (str topic " for the Brave and True"))

(map titleize ["Hamsters" "Ragnaror"]) ; vector

(map titleize '("Empathy" "Decorating")) ; list

(map titleize #{"Elbows" "Soap Carving"}) ; unsorted set

(map #(titleize (second %)) {:uncomfortable-thing "Winking"}) ; map

(seq '(1 2 3)) ; lightweight type conversion
; => (1 2 3)

(seq [1 2 3])
; => (1 2 3)

(seq #{1 2 3})
; => (1 2 3)

(seq {:name "Bill Compton" :occupation "Dead mopey guy"})
([:name "Bill Compton"] [:occupation "Dead mopey guy"])

; into to stick the result into an empty map
(into {} (seq {:a 1 :b 2 :c 3}))

; seq functions examples

; map

(map inc [1 2 3])
(map str ["a" "b" "c"] ["A" "B" "C"])

(def human-consumption [8.1 7.3 6.6 5.0])
(def critter-comsumption [0.0 0.2 0.3 1.1])
(defn unify-diet-data
  [human critter]
  {:human human
   :critter critter})
(map unify-diet-data human-consumption critter-comsumption)

(def sum #(reduce + %))
(def avg #(/ (sum %) (count %)))
(defn stats
  [numbers]
  (map #(%numbers) [sum count avg]))

(stats [3 4 10])

(def identities
  [{:alias "Batman" :real "Bruce Wayne"}
   {:alias "Spider-Man" :real "Peter Parker"}
   {:alias "Santa" :real "Your Mom"}
   {:alias "Easter Bunner" :real "Your Dad"}])
(map :real identities)

; keywords can be used as functions
(def test {:name "Zelda" :friend "Link"})
(:name test)

; reduce
(reduce + [1 2 3 4])
(reduce (fn [new-map [key val]]
          (assoc new-map key (inc val)))
        {}
        {:max 30 :min 10}) ; treat argument as sequence of vector [:max 30] [:min 10]
(assoc {:a 1} :b 2) ; => {:a 1 :b 2}

; assoc-in return a new map with the given value at the specified nesting
(assoc {} [:cookie :monster :vocals] "Finntroll")
(assoc-in {} [:cookie :monster :vocals] "Finntroll")
(get-in {:cookie {:monster {:vocals "Finntroll"}}} [:cookie :monster])
(get {:cookie {:monster {:vocals "Finntroll"}}} :monster) ; => nil

(assoc-in {} [1 :connections 4] 2)
(assoc {:cookie {:monster {:vocals "lala"}}} :hello "Finntroll")

; => {:cookie {:monster {:vocals "Finnstroll"}}}

(reduce (fn [new-map [key val]]
          (if (> val 4)
            (assoc new-map key val)
            new-map))
        {}
        {:human 4.1
         :critter 3.9})

; implementing map using reduce

(map (fn [name]
       (str "Hello " name)) ["Zelda", "Link"])

; take (return first three elements of a sequence)
; drop (drop n elements of a sequence)

(take 3 [1 2 3 4 5 6 7 8 9 10])
(drop 3 [1 2 3 4 5 6 7 8 9 10])

(def food-journal
  [{:month 1 :day 1 :human 5.3 :critter 2.3}
   {:month 1 :day 2 :human 5.1 :critter 2.0}
   {:month 2 :day 1 :human 4.9 :critter 2.1}
   {:month 2 :day 2 :human 5.0 :critter 2.5}
   {:month 3 :day 1 :human 4.2 :critter 3.3}
   {:month 3 :day 2 :human 4.0 :critter 3.8}
   {:month 4 :day 1 :human 3.7 :critter 3.9}
   {:month 4 :day 2 :human 3.7 :critter 3.6}])
(take-while #(< (:month %) 3) food-journal)
(drop-while #(> (:human %) 4) food-journal)

(take-while #(< (:month %) 4)
            (drop-while #(< (:month %) 2) food-journal)) ; get data for just February / March

; filter

(filter #(< (:human %) 5) food-journal)
(filter #(< (:month %) 3) food-journal)

; some

(some #(> (:day %) 10) food-journal) ; => nil
(some #(> (:day %) 1) food-journal) ; => true because the anonymous function return true

(some #(and (> (:critter %) 3) %) food-journal) ; display the result

; sort and sort by
(sort [3 1 2]) ; => (1 2 3)
(sort-by count ["aaa" "c" "bb"])

; concat
(concat [1 2] [3 4]) ; => (1 2 3 4)


; Lazy seqs

; Performance

(def vampire-database {0 {:makes-blood-puns? false, :has-pulse? true :name "McFishwich"}
                       1 {:makes-blood-puns? false, :has-pulse? true :name "McMackson"}
                       2 {:makes-blood-puns? true, :has-pulse? false :name "Damon Salvatore"}
                       3 {:makes-blood-puns? true, :has-pulse? true :name "Mickey Mouse"}})

(defn vampire-related-details
  [social-security-number]
  (Thread/sleep 1000)
  (get vampire-database social-security-number))

(defn vampire?
  [record]
  (and (:makes-blood-puns? record)
       (not (:has-pulse? record))
       record))

(defn identity-vampire
  [social-security-number]
  (first (filter vampire?
                 (map vampire-related-details social-security-number))))
(time (vampire-related-details 0))

(range 0 10)
; => (0 1 2 3 4 5 6 7 8 9)

(time (def mapped-details (map vampire-related-details (range 0 10000000))))
; => "Elapsed time: 0.141076 msecs"
; => #'clojure-noob.core/mapped-details

(time (first mapped-details))
; first time
; => "Elapsed time: 32028.271488 msecs"
; => {:makes-blood-puns? false, :has-pulse? true, :name "McFishwich"}

; second time
; => "Elapsed time: 0.028545 msecs"
; => {:makes-blood-puns? false, :has-pulse? true, :name "McFishwich"}

(time (identity-vampire (range 0 1000000)))
; => "Elapsed time: 32034.671492 msecs"
; => {:makes-blood-puns? true, :has-pulse? false, :name "Damon Salvatore"}

; Infinite sequence

; repeat create an infinite sequence of "na"
(concat (take 8 (repeat "na")) ["Batman!"])

; generate an infinite sequence from the result of a function
(take 3 (repeatedly (fn [] (rand-int 10))))

; construct your own infinite sequence
(defn even-numbers
  ([] (even-numbers 0))
  ([n] (cons n (lazy-seq (even-numbers (+ n 2))))))

(take 10 even-numbers)
(cons 0 `(1 2 3 4))

; The Collection Abstraction

; into 

(map identity {:sunlight-reaction "Glitter!"})
; => ([:sunlight-reaction "Glitter!"])
(into {} (map identity {:sunlight-reaction "Glitter!"}))
; => :sunlight-reaction "Glitter!"

(map identity [:garlic :sesame-oil :fried-eggs])
; => (:garlic :sesame-oil :fried-eggs)
(into [] (map identity [:garlic :sesame-oil :fried-eggs]))
; => [:garlic :sesame-oil :fried-eggs]

(map identity [:garlic-clove :garlic-clove])
; => (:garlic-clove :garlic-clove)
(into #{} (map identity [:garlic-clove :garlic-clove]))
; => {:garlic-clove}

(into {:favorite-emotion "gloomy"} [[:sunlight-reaction "Glitter!"]])

(into ["cherry"] '("pine" "spruce"))

; conj

(conj [0] [1])
; => [0 [1]

(into [0] [1])
; => [0 1]
(conj [0] 1)
; => [0 1]
(conj [0 1 2])
; => [0 1 2]

(conj [0] 1 2 3 4)
(conj {:time "midnight"} [:place "ye olde cemetarium"])

(defn my-conj
  [target & additions]
  (into target additions))

(my-conj [0] 1 2 3)
; => [0 1 2 3]

; Functions Functions

; apply

(max 0 1 2)
; => 2
(max [0 1 2])
; => [0 1 2]
(apply max [0 1 2])
; => 2

(defn my-into
  [target additions]
  (apply conj target additions))
(my-into [0] [1 2 3])

; partial

(def add10 (partial + 10))
(add10 3)
(add10 5)

(def add-missing-elements
  (partial conj ["water" "earth" "air"]))
(add-missing-elements "unobtainium" "adamantium")

(defn my-partial
  [partialized-fn & args]
  (fn [& more-args]
    (apply partialized-fn (into args more-args))))
(def add20 (my-partial + 20))
(add20 3)

(defn lousy-logger
  [log-level message]
  (condp = log-level
    :warn (clojure.string/lower-case message)
    :emergency (clojure.string/upper-case message)))

(def warn (partial lousy-logger :warn))
(warn "Red Light Ahead")

; complement

(defn identify-humans
  [social-security-numbers]
  (filter #(not (vampire? %))
          (map vampire-related-details social-security-number)))

(def not-vampire? (complement vampire?))
(defn identify-humans
  [social-security-numbers]
  (filter not-vampire?
          (map vampire-related-details social-security-numbers)))

(defn my-complement
  [fun]
  (fn [& args]
    (not (apply fun args))))
(def my-pos? (complement neg?))
(my-pos? 1)
(my-pos? -1)
