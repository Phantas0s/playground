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


;; Modeling sock transfers with refs


(def sock-varieties
  #{"darned" "argyle" "wool" "horsehair" "mulleted"
    "passive-aggressive" "striped" "polka-dotted"
    "athletic" "business" "power" "invisible" "gollumed"})

(defn sock-count
  [sock-variety count]
  {:variety sock-variety
   :count count})

(defn generate-sock-gnome
  "Create an initial sock gnome state with no socks"
  [name]
  {:name name
   :socks #{}})

(def sock-gnome (ref (generate-sock-gnome "Barumpharum")))
(def dryer (ref {:name "LG 1337"
                 :socks (set (map #(sock-count % 2) sock-varieties))}))
(:socks @dryer)
; #{{:variety "gollumed", :count 2}
;   {:variety "striped", :count 2}
;   {:variety "wool", :count 2}
;   {:variety "passive-aggressive", :count 2}
;   {:variety "argyle", :count 2}
;   {:variety "business", :count 2}
;   {:variety "darned", :count 2}
;   {:variety "polka-dotted", :count 2}
;   {:variety "horsehair", :count 2}
;   {:variety "power", :count 2}
;   {:variety "athletic", :count 2}
;   {:variety "mulleted", :count 2}
;   {:variety "invisible", :count 2}}

(defn steal-sock
  [gnome dryer]
  (dosync
   (when-let [pair (some #(if (= (:count %) 2) %) (:socks @dryer))]
     (let [updated-count (sock-count (:variety pair) 1)]
       (alter gnome update-in [:socks] conj updated-count)
       (alter dryer update-in [:socks] disj pair)
       (alter dryer update-in [:socks] conj updated-count)))))
(steal-sock sock-gnome dryer)

(defn similar-socks
  [target-sock sock-set]
  (filter #(= (:variety %) (:variety target-sock)) sock-set))

(similar-socks (first (:socks @sock-gnome)) (:socks @dryer))

; idea of in-transaction state

(def counter (ref 0))
(future
  (dosync
   (alter counter inc)
   (println @counter)
   (Thread/sleep 500)
   (alter counter inc)
   (println @counter)))
(Thread/sleep 250)
; value of counter on main thread is still 0 when future executed
(println @counter)

; safe commuting
(defn sleep-print-update
  [sleep-time thread-name update-fn]
  (fn [state]
    (Thread/sleep sleep-time)
    (println (str thread-name ": " state))
    (update-fn state)))
(def counter (ref 0))
(future (dosync (commute counter (sleep-print-update 100 "Thread A" inc))))
(future (dosync (commute counter (sleep-print-update 150 "Thread B" inc))))

; unsafe commuting
(def receiver-a (ref #{}))
(def receiver-b (ref #{}))
(def giver (ref #{1}))
(do (future (dosync (let [gift (first @giver)]
                      (Thread/sleep 10)
                      (commute receiver-a conj gift)
                      (commute giver disj gift))))
    (future (dosync (let [gift (first @giver)]
                      (Thread/sleep 50)
                      (commute receiver-b conj gift)
                      (commute giver disj gift)))))

@receiver-a
; => #{1}

@receiver-b
; => #{1}

@giver
; => #{}



;; Dynamic Vars


(def
  ^:dynamic *notification-address* ; signal the var is dynamic + asterisks (earmuffs)
  "dobby@elf.org")

(binding [*notification-address* "test@elf.org"] *notification-address*)

; stack binding

(binding [*notification-address* "tester-1@elf.org"]
  (println *notification-address*)
  (binding [*notification-address* "tester-2@elf.org"]
    (println *notification-address*))
  (println *notification-address*))

(defn notify-email
  [message]
  (str "TO: " *notification-address* "\n"
       "MESSAGE: " message))
(notify-email "I fell.")
; => "TO: dobby@elf.org\nMESSAGE: test!"

(binding [*notification-address* "test@elf.org"]
  (notify-email "test!"))
; => "TO: test@elf.org\nMESSAGE: test!"

; change *out* to print to a file
(binding [*out* (clojure.java.io/writer "print-output")]
  (println "A man who carries a cat by the tail learns something he can learn in no other way -- Mark Twain"))
(slurp "print-output")

;configuration
(println ["Print" "all" "the" "things!"])
; => [Print all the things!]

(binding [*print-length* 1]
  (println ["Print" "just" "one!"]))

(def ^:dynamic *troll-thought* nil)
(defn troll-riddle
  [your-answer]
  (let [number "man meat"]
    (when (thread-bound? #'*troll-thought*) ; use #' because thread-bound? takes var as argument, not the value it refers to
      (set! *troll-thought* number))
    (if (= number your-answer)
      "TROLL: you can cross the bridge!"
      "TROLL: time to eat you, succulent human!")))

(binding [*troll-thought* nil]
  (println (troll-riddle 2))
  (println "SUCCULENT HUMAN: Oooooh! The answer was" *troll-thought*))
; => TROLL: Time to eat you, succulent human!
; => SUCCULENT HUMAN: Oooooh! The answer was man meat

; see chapter 12 to understand
(.write *out* "prints to repl")

; out not bound to REPL printer; won't work
(.start (Thread. #(.write *out* "prints to standard out")))

; bound-fn carry all the current binding to new thread
(.start (Thread. (bound-fn [] (.write *out* "prints to repl from thread"))))

; altering var root

(def power-source "hair") ;var root "hair"
(alter-var-root #'power-source (fn [_] "7-eleven parking lot"))
power-source
; => "7-elevent parking lot"

(with-redefs [*out* *out*]
  (doto (Thread. #(println "with redefs allows me to show up in the REPL"))
    .start
    .join))

; Stateless concurrency with pmap

; function repeatedly (create lazy seq)
(defn always-1
  []
  1)
(take 5 (repeatedly always-1))
; => (1 1 1 1 1)

(take 5 (repeatedly (partial rand-int 10)))

; compare performance map / pmap

(def alphabet-length 26)
(def letters (mapv (comp str char (partial + 65)) (range alphabet-length)))

; mapv return a seq, map return a lazy seq
(def test (map println [1 2 3]))
(def test2 (mapv println [1 2 3])) ; side effect directly

(defn random-string
  "Returns a random string of specified length"
  [length]
  (apply str (take length (repeatedly #(rand-nth letters)))))

(defn random-string-list
  [list-length string-length]
  (doall (take list-length (repeatedly (partial random-string string-length)))))

(def orc-names (random-string-list 3000 7000))

(time (dorun (map clojure.string/lower-case orc-names)))
; time: 219ms
(time (dorun (pmap clojure.string/lower-case orc-names)))
; time: 115ms

; concurrency overhead

(def orc-names-abbrevs (random-string-list 20000 300))
(time (dorun (map clojure.string/lower-case orc-names-abbrevs)))
; 74 ms
(time (dorun (pmap clojure.string/lower-case orc-names-abbrevs)))
;124 ms

; increase grain size

(def numbers [1 2 3 4 5 6 7 8 9 10])
(partition-all 3 numbers)
; => ((1 2 3) (4 5 6) (7 8 9) (10))

; grain size one - each thread apply one to element
(pmap inc numbers)

; grain size three - each thread 3 applications of the inc function
; doall force the lazy sequence to be realized in the thread
(pmap (fn [number-group] (doall (map inc number-group)))
      (partition-all 3 numbers))
; => ((2 3 4) (5 6 7) (8 9 10) (11))

; ungroup the result
(apply concat
       (pmap (fn [number-group] (doall (map inc number-group)))
             (partition-all 3 numbers)))
; => (2 3 4 5 6 7 8 9 10 11)

(time
 (dorun
  (apply concat
         (pmap (fn [name] (doall (map clojure.string/lower-case name)))
               (partition-all 1000 orc-names-abbrevs)))))
; 45ms

; can do a function from that, for fun

(defn ppmap
  "Partitioned pmap, for grouping maps ops together to make parallel overhead worthwhile"
  [grain-size f & colls]
  (apply concat
         (apply pmap
                (fn [& pgroups] (doall (apply map f pgroups)))
                (map (partial partition-all grain-size) colls))))
(time (dorun (ppmap 1000 clojure.string/lower-case orc-names-abbrevs)))
; => 46ms
