;1. Use the str, vector, list, hash-map, and hash-set functions.
;2. Write a function that takes a number and adds 100 to it.

(defn add-one-hundred
  [number]
  (+ number 100))
(add-one-hundred 10)
(add-one-hundred 2231)

; 3. Write a function, dec-maker, that works exactly like the function inc-maker except with subtraction:
; (def dec9 (dec-maker 9))
; (dec9 10)

(defn dec-maker
  [dec-by]
  #(- % dec-by))
(def dec9 (dec-maker 9))
(dec9 10)

;4. Write a function, mapset, that works like map except the return value is a set

; (defn mapset
;   [func collection]
;   (loop [coll collection
;          result []]
;     (if (empty? coll)
;       (result)
;       (let [[part & remaining] coll]
;         println ((func part))
;         ; (into result (func part))
;         (recur remaining result)))))
; (mapset inc [1 1 2 2])

(defn mapset
  [func coll]
  (into #{} (map func coll)))
(mapset #(str "hello" %) ["hey" "ho"])

(defn mapset'
  [f coll]
  (loop [remaincoll coll
         result #{}]
    (if (empty? remaincoll)
      result
      (let [[part & remaining] remaincoll]
        (recur remaining
               (conj result (f part)))))))
(mapset' #(str "hello" %) ["hey" "ho"])
(mapset' inc [1 2])

; 5. Create a function that’s similar to symmetrize-body-parts except that it has to work with weird space aliens with radial symmetry. 
; Instead of two eyes, arms, legs, and so on, they have five.

(def asym-alien-body-parts [{:name "head" :size 3}
                            {:name "first-eye" :size 1}
                            {:name "first-ear" :size 1}
                            {:name "mouth" :size 1}
                            {:name "nose" :size 1}
                            {:name "neck" :size 2}
                            {:name "first-shoulder" :size 3}
                            {:name "first-upper-arm" :size 3}
                            {:name "chest" :size 10}
                            {:name "back" :size 10}
                            {:name "first-forearm" :size 3}
                            {:name "abdomen" :size 6}
                            {:name "first-kidney" :size 1}
                            {:name "first-hand" :size 2}
                            {:name "first-knee" :size 2}
                            {:name "first-thigh" :size 4}
                            {:name "first-lower-leg" :size 3}
                            {:name "first-achilles" :size 1}
                            {:name "first-foot" :size 2}])

(defn matching-part
  [part part-prefix]
  {:name (clojure.string/replace (:name part) #"^first" part-prefix)
   :size (:size part)})

(defn symmetrize-body-parts
  "Expects a seq of maps that have a :name and :size"
  [asym-body-part]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set [part
                                         (matching-part part "second")
                                         (matching-part part "third")
                                         (matching-part part "fourth")
                                         (matching-part part "fifth")])))
          []
          asym-body-part))

(symmetrize-body-parts asym-alien-body-parts)

(defn hit
  [asym-body-parts]
  (let [sym-parts (symmetrize-body-parts asym-body-parts)
        body-part-size-sum (reduce + (map :size sym-parts))
        target (rand body-part-size-sum)]
    (loop [[part & remaining] sym-parts
           accumulated-size (:size part)]
      (if (> accumulated-size target)
        part
        (recur remaining (+ accumulated-size (:size (first remaining))))))))

(hit asym-alien-body-parts)

; 6. Create a function that generalizes symmetrize-body-parts and the function you created in Exercise 5. 
; The new function should take a collection of body parts and the number of matching body parts to add. 
; If you’re completely new to Lisp languages and functional programming, it probably won’t be obvious how to do this. 
; If you get stuck, just move on to the next chapter and revisit the problem later.

(def asym-alien-body-parts [{:name "head" :size 3}
                            {:name "eye-0" :size 1}
                            {:name "ear-0" :size 1}
                            {:name "mouth" :size 1}
                            {:name "nose" :size 1}
                            {:name "neck" :size 2}
                            {:name "shoulder-0" :size 3}
                            {:name "upper-arm-0" :size 3}
                            {:name "chest" :size 10}
                            {:name "back" :size 10}
                            {:name "first-forearm" :size 3}
                            {:name "abdomen" :size 6}
                            {:name "kidney-0" :size 1}
                            {:name "hand-0" :size 2}
                            {:name "knee-0" :size 2}
                            {:name "thigh-0" :size 4}
                            {:name "lower-leg-0" :size 3}
                            {:name "achilles-0" :size 1}
                            {:name "foot-0" :size 2}])

(defn matching-part
  [part part-number]
  {:name (clojure.string/replace (:name part) #"0$" (str part-number))
   :size (:size part)})

(defn assemble-parts
  [part total-parts count-part result]
  (if (= count-part total-parts)
    result
    (recur part total-parts (+ count-part 1) (into result [(matching-part part count-part)]))))

(defn symmetrize-body-parts
  "Expects a seq of maps that have a :name and :size"
  [asym-body-part total-parts]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (assemble-parts part total-parts 1 (set [part]))))
          []
          asym-body-part))
(symmetrize-body-parts asym-alien-body-parts 3)
