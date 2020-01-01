(def asym-hobbit-body-parts [{:name "head" :size 3}
                             {:name "left-eye" :size 1}
                             {:name "left-ear" :size 1}
                             {:name "mouth" :size 1}
                             {:name "nose" :size 1}
                             {:name "neck" :size 2}
                             {:name "left-shoulder" :size 3}
                             {:name "left-upper-arm" :size 3}
                             {:name "chest" :size 10}
                             {:name "back" :size 10}
                             {:name "left-forearm" :size 3}
                             {:name "abdomen" :size 6}
                             {:name "left-kidney" :size 1}
                             {:name "left-hand" :size 2}
                             {:name "left-knee" :size 2}
                             {:name "left-thigh" :size 4}
                             {:name "left-lower-leg" :size 3}
                             {:name "left-achilles" :size 1}
                             {:name "left-foot" :size 2}])

(defn matching-part
  [part]
  {:name (clojure.string/replace (:name part) #"^left-" "right-")
   :size (:size part)})

(defn symmetrize-body-parts
  "Expects a seq of maps that have a :name and a :size"
  [asym-body-part]
  (loop [remaining-asym-parts asym-body-part
         final-body-parts []]
    (if (empty? remaining-asym-parts)
      final-body-parts
      (let [[part & remaining] remaining-asym-parts] ; simplify the code instead of (set [(first remaining-asym-parts) (matching-part (first remaining-asym-parts))])))
        (recur remaining
               (into final-body-parts ; add set into final body parts
                     (set [part (matching-part part)]))))))) ; set because part and (matching-part part) are sometimes the same thing

(symmetrize-body-parts asym-hobbit-body-parts)

; let

(let [x 3]
  x)

(def dalmatian-list
  ["Pongo" "Perdita" "Puppy 1" "Puppy 2"])
(let [dalmatians (take 2 dalmatian-list)]
  dalmatians)
(let [string (str "This " " is " " NOT " " a string ")] string)

(def x 0)
(let [x 1] x) ;different scope

(def x 0) ;x is 0 in global scope
(let [x (inc x)] x) ;reference existing binding
x ;x is still 0

; rest parameter in let
; follow same rules of destructuring as functions
(let [[pongo & dalmatians] dalmatian-list]
  [pongo dalmatians])

; into
(into [] (set [:a :a])) ; => [:a]

; loop - another way to do recursion

(loop [iteration 0]
  (println (str "Iteration " iteration))
  (if (> iteration 3)
    (println "Goodbye!")
    (recur (inc iteration))))

(defn recursive-printer ;same thing than loop; loop is faster though
  ([] ; two arrities
   (recursive-printer 0))
  ([iteration]
   (println iteration)
   (if (> iteration 3)
     (println "Goodbye!")
     (recursive-printer (inc iteration)))))
(recursive-printer)

; regular expression

#"regular-expression"

(re-find #"^left-" "left-eye")
(re-find #"^left-" "cleft-chin")
(re-find #"^left-" "wongleblart")

; (loop [c 10 othercount 1]
;   (if (> othercount 3)
;     (println "Goodbye!")
;     (do (inc othercount)
;         (println c)
;         (println othercount)
;         (recur c othercount))))

; why is it an infinite loop??

; reduce
(reduce + [1 2 3 4]) ; equivalent (+ (+ (+ 1 2) 3) 4)
(reduce + 15 [1 2 3 4]) ; with initial value

(defn my-reduce
  ([f initial coll]
   (loop [result initial
          remaining coll]
     (if (empty? remaining)
       result
       (recur (f result (first remaining)) (rest remaining)))))
  ([f [head & tail]]
   (my-reduce f head tail)))

(defn better-symmetrize-body-parts
  "Expects a seq of maps that have a :name and :size"
  [asym-body-part]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set [part (matching-part part)])))
          []
          asym-body-part))

(defn hit
  [asym-body-parts]
  (let [sym-parts (better-symmetrize-body-parts asym-body-parts)
        body-part-size-sum (reduce + (map :size sym-parts))
        target (rand body-part-size-sum)]
    (loop [[part & remaining] sym-parts
           accumulated-size (:size part)]
      (if (> accumulated-size target)
        part
        (recur remaining (+ accumulated-size (:size (first remaining))))))))

(hit asym-hobbit-body-parts)
