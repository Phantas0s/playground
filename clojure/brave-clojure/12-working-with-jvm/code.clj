; All clojure strings implement as Java String
; Syntax to call a method (.
(.toUpperCase "By Bluebeard's bananas!")
; => MY BLUEBEARD'S BANANAS

(.indexOf "Let's synergize our bleeding edges" "y")
; => 7

; Equivalent in Java
; "By Bluebeard's bananas!".toUpperCase()
; "Let's synergize our bleeding edges".indexOf("y")

; call static methods

(java.lang.Math/abs -3)
; => 3

java.lang.Math/PI
; => 3.141592653589793

; Macro expansion of dot syntax
(macroexpand-1 '(.toUpperCase "By Bluebeard bananas!"))
(. "By Bluebeard bananas!" toUpperCase)

(macroexpand-1 '(.indexOf "Let's synergize our bleeding edges" "y"))
; => (. "Let's synergize our bleeding edges" indexOf "y")

(macroexpand-1 '(Math/abs -3))
; => (. Math abs -3)

; general form of dot operator
; (. object-expr-or-classname-symbol method-or-member-symbol optional-args*)

; Creating and mutating objects

(new String)
; => ""
(String.)
; => ""
(String. "To Davey Jone's Locker with ye hardies")
; => "To Davey Jone's Locker with ye hardies"

; create a stack and add an object to it

(java.util.Stack.)
; => []

; needs to create let binding and return stack
(let [stack (java.util.Stack.)]
  (.push stack "Latest episode of The Sopranos, ho!") ; only return the last-in
  stack)
; => ["Latest episode of The Sopranos, ho!"]
; Use square bracket syntax, even if it's not a vector

; can use Clojure's seq functions
(let [stack (java.util.Stack.)]
  (.push stack "Latest episode of The Sopranos, ho!") ; only return the last-in
  (first stack))
; => "Latest episode of Game of Throne, oh!"

; doto - always return object instead of method calls
(doto (java.util.Stack.)
  (.push "Latest episode of The Sopranos, oh!")
  (.push "Whoops, I meant 'Land, oh!'"))
; => ["Latest episode of The Sopranos, oh!" "Whoops, I meant 'Land, oh!'"]


;; importing


(import java.util.Stack)
(Stack.)
; => []

; (import [package.name1 ClassName1 ClassName2]
;         [package.name2 ClassName3 ClassName4])

(import [java.util Date Stack]
        [java.net Proxy URI])
(Date.)
; => #inst "2020-04-28T11:56:37.115-00:00"

; usually

(ns pirate.talk
  (:import [java.util Date Stack]
           [java.net Proxy URI]))

; system class
(System/getenv)
(System/getProperty "user.dir")
; => directory JVM started from
(System/getProperty "java.version")
; => version of JVM


; Files and Input / Output

; can use that
(let [file (java.io.File. "/")]
  (println (.exists file))
  (println (.canWrite file))
  (println (.getPath file)))

; Clojure gives functions which unify reading / writing accross different kind of resource

(spit "/tmp/hercules-todo-list"
      "- kill dat lion brov
      - chop up what nasty multi-headed snake thing")
(slurp "/tmp/hercules-todo-list")
; => "- kill dat lion brov
;     - chop up what nasty multi-headed snake thing"

; Using a stringwriter
(let [s (java.io.StringWriter.)]
  (spit s "- capture cerynian hind like for real")
  (.toString s))
; => "- capture cerynian hind like for real""

(let [s (java.io.StringReader. "- get erymanthian pig what with the tusks")]
  (slurp s))
; => "- get erymanthian pig what with the tusks"

; reading a file one line at a time - slurp won't work here
; with-open will close resource automatically at the end of its body
(with-open [todo-list-rdr (clojure.java.io/reader "/tmp/hercules-todo-list")]
  (println (first (line-seq todo-list-rdr))))
; => - kill dat lion brov
