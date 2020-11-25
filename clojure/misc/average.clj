; From "All I needed for FP I learned in High School Algebra - Eric Normand" (https://www.youtube.com/watch?v=epT1xgxSpFU)
; Make the whole operation commutative and associtive.
; Monoid: identity value (0 here) and associative.

(defn combine [[sum1 count1] [sum2 count2]]
  [(+ sum1 sum2) (+ count1 count2)])

(defn ->average [number]
  [number 1])

(defn ratio [numbers]
  (reduce combine [0 0] (map ->average numbers)))
; (average [10 20])
; => [30 2]

(defn average-> [[sum count]]
  (/ sum count))

(defn average [numbers]
  (->> numbers
       (map ->average)
       (reduce combine [0 0]) ; leverage to average
       (average->))) ; back down

; The following is not associative

(defn average [a b]
  (/ (+ a b) 2))
