(deftask fire
  "Prints 'My pants are on fire!'"
  []
  (println "My pants are on fire!"))

; t -> short name
; thing -> long name
; THING -> optargs - indicate that it expects argument, and more powerful thing (if you want vector, nested collections...) See https://github.com/boot-clj/boot/wiki/Task-Options-DSL#complex-options
; str -> option type
(deftask fire-thing
  "Announces that something is on fire!"
  [t thing THING str "The thing that on fire"
   p pluralize bool "Whether to pluralize"]
  (let [verb (if pluralize "are" "is")]
    (println "My" thing verb "on fire!")))


; composing everyday functions


(def strinc (comp str inc))
(strinc 3)

; middleware
(defn whiney-str
  [rejects]
  {:pre [(set? rejects)]}
  (fn [x]
    (if (rejects x)
      (str "I don't like " x)
      (str x))))

(def whiney-strinc (comp (whiney-str #{2}) inc))
(whiney-strinc 1)

(defn whiney-middleware
  [next-handler rejects]
  {:pre [(set? rejects)]}
  (fn [x]
    (if (= x 1)
      "I'm not going to do anything about that"
      (let [y (next-handler x)]
        (if (rejects y)
          (str "I don't like " y)
          (str y))))))
(def whiney-strinc (whiney-middleware inc #{2}))
(whiney-strinc 1)

; middleware factory
(defn whiney-middleware-factory
  [rejects]
  {:pre [(set? rejects)]}
  (fn [handler]
    (fn [x]
      (if (= x 1)
        "I'm not going to bother doing anything to that"
        (let [y (handler x)]
          (if (rejects y)
            (str "I don't like " y " :'(")
            (str y)))))))
(def whiney-strinc ((whiney-middleware-factory #{3}) inc))

; middleware-factory with boot
(deftask what
  "Specify a thing"
  [t thing THING str "An object"
   p pluralize bool "Whether to pluralize"]
  (fn middleware [next-handler]
    (fn handler [fileset]
      (next-handler (merge fileset {:thing thing :pluralize pluralize})))))

(deftask fire-middleware
  "Announce a thing is on fire"
  []
  (fn middleware [next-handler]
    (fn handler [fileset]
      (let [verb (if (:pluralize fileset) "are" "is")]
        (println "My" (:thing fileset) verb "on fire!")
        fileset))))
