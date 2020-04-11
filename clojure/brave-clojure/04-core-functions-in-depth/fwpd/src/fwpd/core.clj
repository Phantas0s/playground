(ns fwpd.core)
(def filename "suspects.csv")

(def vamp-keys [:name :glitter-index])

(defn str->int
  [str]
  (Integer. str))

(def conversions {:name identity
                  :glitter-index str->int})

(defn convert
  [vamp-key value]
  ((get conversions vamp-key) value))

(convert :glitter-index "3")

(defn parse
  "Convert a CSV into rows and columns"
  [string]
  (map #(clojure.string/split % #",")
       (clojure.string/split string #"\n")))
(parse (slurp filename))

(defn mapify
  "Return a seq of maps like {:name \"Edward Cullen\" :glitter-index 10}"
  [rows]
  (map (fn [unmapped-row]
         (reduce (fn [row-map [vamp-key value]]
                   (assoc row-map vamp-key (convert vamp-key value)))
                 {}
                 (map vector vamp-keys unmapped-row)))
       rows))

(defn glitter-filter
  [minimum-glitter records]
  (filter #(>= (:glitter-index %) minimum-glitter) records))

(glitter-filter 3 (mapify (parse (slurp filename))))

; Exercises

; 1. Turn the result of your glitter filter into a list of names.

(defn glitter-filter-name
  [minimum-glitter records]
  (map :name (filter #(>= (:glitter-index %) minimum-glitter) records)))

(glitter-filter-name 3 (mapify (parse (slurp filename))))

; 2. Write a function, append, which will append a new suspect to your list of suspects.

(defn append-suspect
  [new-name new-glitter list-names]
  (concat list-names [{:name new-name :glitter-index new-glitter}]))

(append-suspect "Bella Lugosi" 12312312 (mapify (parse (slurp filename))))

; 3. Write a function, validate, which will check that :name and :glitter-index are present when you append. The validate function should accept two arguments: a map of keywords to validating functions, similar to conversions, and the record to be validated.

; (defn validate
;   [vamp-keys suspect]
;   (loop [vamp-keys vamp-key
;          suspect-map suspect
;          final-keys []]
;     if ))
;   (= (count new-map) (count vamp-keys))
; (validate [:name :glitter-index] {:name "name" :glitter-index "1"})
