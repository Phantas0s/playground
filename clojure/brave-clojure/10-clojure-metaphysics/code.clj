;; atoms


; fred refers to the value {:cuddle-hunger-level 0 :percent-deteriorated 0}
(def fred (atom {:cuddle-hunger-level 0
                 :percent-deteriorated 0}))

; get atom current state (dereference it)
@fred

; each state is immutable
(let [zombie-state @fred]
  (if (>= (:percent-deteriorated zombie-state) 50)
    (future (println (:cuddle-hunger-level zombie-state)))))

; change reference type of atom
(swap! fred
       (fn [current-state]
         (merge-with + current-state {:cuddle-hunger-level 1})))

; unline in Ruby, can change two states at the same time; no risk that another thread read the value between change of two states
(swap! fred
       (fn [current-state]
         (merge-with + current-state {:cuddle-hunger-level 1
                                      :percent-deteriorated 1})))
; swap! with function with 2 arguments
(defn increase-cuddle-hunger-level
  [zombie-state increase-by]
  (merge-with + zombie-state {:cuddle-hunger-level increase-by}))

; this function doesn't actually update fred, because we don't use swap!
(increase-cuddle-hunger-level @fred 10)
; fred still has the same state
@fred

(swap! fred increase-cuddle-hunger-level 10)
; this time, fred reference type updated
@fred

; update-in
(update-in {:a {:b 3}} [:a :b] inc)
; => {:a {:b 4}
(update-in {:a {:b 3}} [:a :b] + 10)
; => {:a {:b 13}
(swap! fred update-in [:cuddle-hunger-level] + 10)
; => {:cuddle-hunger-level 22, :percent-deteriorated 1}

; can retain past states with atoms (?!!)
(let [num (atom 1)
      s1 @num]
  (swap! num inc)
  (println "state 1: " s1)
  (println "current state: " @num))

; update atom without checking its current value
(reset! fred {:cuddle-hunger-level 0
              :percent-deteriorated 0})


;; Watches


(defn shuffle-speed
  [zombie]
  (* (:cuddle-hunger-level zombie)
     (- 100 (:percent-deteriorated zombie))))
(defn shuffle-alert
  [key watched old-state new-state]
  (let [sph (shuffle-speed new-state)]
    (if (> sph 5000)
      (do
        (println "Run, you fool!")
        (println "The zombie SPH is now " sph)
        (println "This message brought to your courtesy of " key))
      (do
        (println "All's well with " key)
        (println "Cuddle hunger: " (:cuddle-hunger-level new-state))
        (println "Percent deteriorated: " (:percent-deteriorated new-state))
        (println "SPH: " sph)))))
(reset! fred {:cuddle-hunger-level 22
              :percent-deteriorated 2})
(add-watch fred :fred-shuffle-alert shuffle-alert)
(swap! fred update-in [:percent-deteriorated] + 1)
; => All's well with  :fred-shuffle-alert
; => Cuddle hunger:  22
; => Percent deteriorated:  3
; => SPH:  2134

(swap! fred update-in [:cuddle-hunger-level] + 30)
; => Run, you fool!
; => The zombie SPH is now  5044
; => This message brought to your courtesy of  :fred-shuffle-alert
; => {:cuddle-hunger-level 52, :percent-deteriorated 3}


;; Validators


(defn percent-deteriorated-validator
  [{:keys [percent-deteriorated]}]
  (and (>= percent-deteriorated 0)
       (<= percent-deteriorated 100)))

(def bobby
  (atom
   {:cuddle-hunger-level 0 :percent-deteriorated 0}
   :validator percent-deteriorated-validator))
(swap! bobby update-in [:percent-deteriorated] + 200)
; => throws "invalid reference state"

; can throw exception
(defn percent-deteriorated-validator
  [{:keys [percent-deteriorated]}]
  (or (and (>= percent-deteriorated 0)
           (<= percent-deteriorated 100))
      (throw (IllegalStateException. "That's not mathy!"))))

(def bobby
  (atom
   {:cuddle-hunger-level 0 :percent-deteriorated 0}
   :validator percent-deteriorated-validator))
(swap! bobby update-in [:percent-deteriorated] + 200)
; => throws "invalid reference state: That's not mathy!"
