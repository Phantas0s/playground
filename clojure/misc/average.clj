; From "All I needed for FP I learned in High School Algebra - Eric Normand" (https://www.youtube.com/watch?v=epT1xgxSpFU)
; Make the whole operation commutative and associtive.

(defn combine [[sum1 count1] [sum2 count2]]
  [(+ sum1 sum2) (+ count1 count2)])

(defn ->average [number]
  [number 1])

(defn average [numbers]
  (reduce combine [0 0] (map ->average numbers)))
; (average [10 20])
; => [30 2]

; The following is not associative

(defn average [a b]
  (/ (+ a b) 2))
