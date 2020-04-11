; namespace you're actually in
(ns-name *ns*)

inc
; => #object[clojure.core$inc "0x5d8636b7" "clojure.core$inc@5d8636b7"]
'inc
; => inc
(map inc [1 2])
; => (2 3)
'(map inc [1 2])
; => (map inc [1 2])

(def great-books ["Esat of Eden" "The Glass Bead Game"])
; => #'peg-thing.core/great-books

; list of interned var
(ns-interns *ns*)
; => #'peg-thing.core/great-books

; get a specific var
(get (ns-interns *ns*) 'great-books)
; => #'peg-thing.core/great-books

; full map of namespace uses for looking up a var when given a symbol.
(ns-map *ns*)

; #' to grab hold of the var corresponding to the symbol that follows
(deref #'peg-thing.core/great-books)
; => ["East of Eden" "The Glass Bead Game"]

; update var with new vector
(def great-books ["The Power of Bees" "Journey to Upstairs"])
great-books
; => ["The Power of Bees" "Journey to Upstairs"]
; name collision
; solution: creating new namespaces

; Creating and Switching to Namespaces

(create-ns 'cheese.taxonomy)
(ns-name (create-ns 'cheese.taxonomy))
; => cheese.taxonomy

(in-ns 'cheese.analysis)
(def test "lala")
; => #'cheese.analysis/test


(in-ns 'cheese.taxonomy)
(def cheddars ["mild" "medium" "strong" "sharp" "extra sharp"])
(in-ns 'cheese.analysis)
cheddars
; => exception
cheese.taxonomy/cheddars
; => ["mild" "medium" "strong" "sharp" "extra sharp"]

; how to access namespace without typing it

(in-ns 'cheese.taxonomy)
(def cheddars ["mild" "medium" "strong" "sharp" "extra sharp"])
(def bries ["Wisconsin" "Somerset" "Brie de Meaux" "Brie de Melun"])
(in-ns 'cheese.analysis)
(clojure.core/refer 'cheese.taxonomy)
bries
; => ["Wisconsin" "Somerset" "Brie de Meaux" "Brie de Melun"]
cheddars
; => ["mild" "medium" "strong" "sharp" "extra sharp"]

(clojure.core/get (clojure.core/ns-map clojure.core/*ns*) 'bries)
; => #'cheese.taxonomy/bries

; if refer used with only
(clojure.core/refer 'cheese.taxonomy :only ['bries])
; => ["Wisconsin" "Somerset" "Brie de Meaux" "Brie de Melun"]
cheese.analysis=> cheddars
; => RuntimeException: Unable to resolve symbol: cheddars

;if refer used with :exclude

(clojure.core/refer 'cheese.taxonomy :exclude ['bries])
bries
; => RuntimeException: Unable to resolve symbol: bries
cheddars
; => ["mild" "medium" "strong" "sharp" "extra sharp"]

(clojure.core/refer 'cheese.taxonomy :rename {'bries 'yummy-bries})
bries
; => RuntimeException: Unable to resolve symbol: bries
yummy-bries
; => ["Wisconsin" "Somerset" "Brie de Meaux" "Brie de Melun"]


; referencing clojure namespace in a new namespace (to have access to core clojure functions)
(clojure.core/refer-clojure)
(refer 'cheese.taxonomy)
bries

; private functions
(in-ns 'cheese.analysis)
;; Notice the dash after "defn"
(defn- private-function
  "just an example function that does nothing"
  [])

(in-ns 'cheese.taxonomy)
(clojure.core/refer-clojure)
(cheese.analysis/private-function)
(refer 'cheese.analysis :only ['private-function])
; => IllegalAccessError

; alias

(clojure.core/alias 'taxonomy 'cheese.taxonomy)
taxonomy/bries
; => ["Wisconsin" "Somerset" "Brie de Meaux" "Brie de Melun"]
