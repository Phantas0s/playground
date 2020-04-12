; atom
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
