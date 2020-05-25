(defmulti full-moon-behavior (fn [were-creatures] (:were-type were-creatures)))
(defmethod full-moon-behavior :wolf
  [were-creature]
  (str (:name were-creature) " will howl and murder"))
(defmethod full-moon-behavior :simmons
  [were-creature]
  (str (:name were-creature) " will encourage people and sweat to the oldies"))

(full-moon-behavior {:were-type :wolf
                     :name "Rachel from next door"})
; => "Rachel from next door will howl and murder"

(full-moon-behavior {:name "Andy the baker"
                     :were-type :simmons})
; => "Andy the baker will encourage people and sweat to the oldies"

; Can use nil as dispatching value
(defmethod full-moon-behavior nil
  [were-creature]
  (str (:name were-creature) " will stay at home and eat ice cream"))

(full-moon-behavior {:were-type nil
                     :name "Martin the nurse"})
; => "Martin the nurse will stay at home and eat ice cream"

; Can specify default method
(defmethod full-moon-behavior :default
  [were-creature]
  (str (:name were-creature) " will stay up al night fantasy footballing"))

(full-moon-behavior {:were-type :office-worker
                     :name "Jimmy from sales"})
; => "Jimmy from sales will stay up all night fantasy footballing"

; (ns random-namespace
;   (:require [were-creatures]))
; (defmethod were-creatures/full-moon-behavior :bill-murray
;   [were-creature]
;   (str (:name were-creature) " will be the most likeable celebrity"))
; (were-creatures/full-moon-behavior {:name "Laura the intern"
;                                     :were-type :bill-murray})
; => "Laura the intern will be the most likeable celebrity"

(defmulti types (fn [x y] [(class x) (class y)]))
(defmethod types [java.lang.String java.lang.String]
  [x y]
  "Two strings!")
(types "String 1" "String 2")


; Protocols


(defprotocol Psychodynamics
  "Plumb the inner depths of your data types"
  (thoughts [x] "The data type's innermost thoughts")
  (feeling-about [x] [x y] "Feelings about self or other"))
; can't have rest arguments: not allowed (feelings-about [x] [x & others])

; needs to implement every method of a protocol
(extend-type java.lang.String
  Psychodynamics
  (thoughts [x] (str x " thinks, 'Truly, the character defines the data type'"))
  (feeling-about
    ([x] (str x " is longing for a simpler way of life"))
    ([x y] (str x " is envious of " y "'s simpler way of life"))))
(thoughts "blorb")
; => "blorb thinks, 'Truly, the character defines the data type'"

(feeling-about "schmorb")
; => "schmorb is longing for a simpler way of life"

(feeling-about "schmorb" 2)
; => "schmorb is envious of 2's simpler way of life"

; Default implementation possible (everything in Java is a child of java.lang.Object, even Clojure!)
(extend-type java.lang.Object
  Psychodynamics
  (thoughts [x] "Maybe the Internet is just a vector for toxoplasmosis")
  (feelings-about
    ([x] "meh")
    ([x y] (str "meh about " y))))

(thoughts 3)
; => "Maybe the Internet is just a vector for toxoplasmosis"

(feeling-about 3)
; => "meh"

(feeling-about 3 "blorb")
; => "meh about blorb"


; Records


; (ns were-records)
(defrecord WereWolf [name title])

; three way to create instance of WereWolf

; same way we create Java object. List of fields need to have same order as defined.
(WereWolf. "David" "London Tourist")
; => #were_records.WereWolf{:name "David", :title "London Tourist"}

(->WereWolf "Jacob" "Lead Shirt Discarder")
; => #were_records.WereWolf{:name "Jacob", :title "Lead Shirt Discarder"}

(map->WereWolf {:name "Lucian" :title "CEO of melodrama"})
; => #were_records.WereWolf{:name "Lucian", :title "CEO of Melodrama"}

; Import in another namespace
; (ns monster-mash
;   (:import [were_records WereWolf]))
; (WereWolf. "David" "London Tourist")

(def jacob (->WereWolf "Jacob" "Lead Shirt Discarder"))
(.name jacob)
; => "Jacob"
(:name jacob)
; => "Jacob"
(get jacob :name)
; => "Jacob"

(= jacob (->WereWolf "Jacob" "Lead Shirt Discarder"))
; => true
(= jacob (WereWolf. "Jacob" "London Tourist"))
; => false
(= jacob (WereWolf. "David" "London Tourist"))
; => false
(= jacob {:name "Jacob" :title "Lead Shirt Discarder"})
; => false

(assoc jacob :title "Lead Third Wheel")
; => #clojure_noob.core.WereWolf{:name "Jacob", :title "Lead Third Wheel"}

(dissoc jacob :title)
; => {:name "Jacob"} <- that's not a were_records.WereWolf

; using protocol

(defprotocol WereCreature
  (full-moon-behavior [x]))

(defrecord WereWolf [name title]
  WereCreature
  (full-moon-behavior [x]
    (str name " will howl and murder")))

(full-moon-behavior (map->WereWolf {:name "Lucian" :title "CEO of Melodrama"}))
