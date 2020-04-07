(defmacro infix
  "Use this macro when you pine about the notation of your childhood"
  [infixed]
  (list (second infixed) (first infixed) (last infixed)))

(infix (1 + 1))
; => 2

(macroexpand '(infix (1 + 2)))
; => (+ 1 2)

; destructuration
(defmacro infix-2
  [[operand1 op operand2]]
  (list op operand1 operand2))

(infix-2 (1 + 1))
; => 2


; multiple-arrity macro
; macro and
(defmacro and
  "Evaluates exprs one at a time, from left to right. If a form
  returns logical false (nil or false), and returns that value and
  doesn't evaluate any of the other expressions, otherwise it returns
  the value of the last expr. (and) returns true."
  {:added "1.0"}
  ([] true) ;0-arity returning true
  ([x] x) ;1-arity returning param
  ([x & next] ;n-arity recursively call itself
   `(let [and# ~x]
      (if and# (and ~@next) and#))))

; simple quoting - turn off evaluation
(+ 1 2)
; => 3
(quote (+ 1 2))
; => (+ 1 2)

; reader-macro '
'(+ 1 2)
; => (+ 1 2)

; implementation of when macro
(defmacro when
  "Evaluates test. If logical true, evaluates body in an implicit do."
  {:added "1.0"}
  [test & body]
  (list 'if test (cons 'do body)))

(macroexpand '(when true ("hello")))
; => (if true (do ("hello")))

(macroexpand '(when (the-cows-come :home)
                (call me :pappy)
                (slap me :silly)))
; (if (the-cows-come :home) (do (call me :pappy) (slap me :silly)))

; built-in macro unless
(defmacro unless
  "inverted 'If'"
  [test & branches]
  (conj (reverse branches) test 'if))

(macroexpand '(unless (done-been slapped? me)
                      (slap me :silly)
                      (say "I reckon that'll learn me")))
; => (if (done-been slapped? me) (say "I reckon that'll learn me") (slap me :silly))

; syntax quoting

`+
; => clojure.core/+

`(+ 1 (inc 1))
; => (clojure.core/+ 1 (clojure.core/inc 1))

; unquote form
`(+ 1 ~(inc 1))
; => (clojure.core/+ 1 2)

; unquoting more consice

(list '+ 1 (inc 2))
`(+ 1 ~(inc 2))


; Improvement and refactoring

; First version


(defmacro code-critic
  "Phrases are courtesy Hermes Conrad from Futurama"
  [bad good]
  (list 'do
        (list 'println
              "Great squid of Madrid, this is bad code:"
              (list 'quote bad))
        (list 'println
              "Sweet Gorilla of Manilla, this is good code:"
              (list 'quote good))))
(code-critic (1 + 2) (+ 1 2))
(macroexpand '(code-critic (1 + 2) (+ 1 2)))
; => (do (println "Great squid of Madrid, this is bad code:" (quote (1 + 2))) (println "Sweet Gorilla of Manilla, this is good code:" (quote (+ 1 2))))

; ==============================================================

; Second version
(defmacro code-critic
  "Phrases are courtesy Hermes Conrad from Futurama"
  [bad good]
  `(do
     (println "Great squid of Madrid, this is bad code:" (quote ~bad))
     (println "Sweet Gorilla of Manilla, this is good code:" (quote ~good))))
(code-critic (1 + 2) (+ 1 2))
(macroexpand '(code-critic (1 + 2) (+ 1 2)))
; => (do (clojure.core/println "Great squid of Madrid, this is bad code:" (quote (1 + 2))) (clojure.core/println "Sweet Gorilla of Manilla, this is good code:" (quote (+ 1 2))))

; ==============================================================

; Third version
(defn criticize-code
  [criticism code]
  `(println ~criticism (quote ~code)))

(defmacro code-critic
  "Phrases are courtesy Hermes Conrad from Futurama"
  [bad good]
  `(do
     ~(criticize-code "Great squid of Madrid, this is bad code:" good)
     ~(criticize-code "Sweet Gorilla of Manilla, this is good code:" bad)))
(code-critic (1 + 2) (+ 1 2))


; ==============================================================

; Fourth version


(defn criticize-code
  [criticism code]
  `(println ~criticism (quote ~code)))

(defmacro code-critic
  "Phrases are courtesy Hermes Conrad from Futurama"
  [bad good]
  `(do ~(map #(apply criticize-code %)
             [["Great squid of Madrid, this is bad code:" good]
              ["Sweet Gorilla of Manilla, this is good code:" bad]])))
(code-critic (1 + 2) (+ 1 2))
; => NullPointerException (trying to evaluate the returned nil from println)

(macroexpand '(code-critic (1 + 2) (+ 1 2)))
; => (do ((clojure.core/println "Great squid of Madrid, this is bad code:" (quote (+ 1 2))) (clojure.core/println "Sweet Gorilla of Manilla, this is good code:" (quote (1 + 2)))))
; map wrap everything into one list
; ... need to unwrap

; unquote splicing
`(+ ~(list 1 2 3))
; => (clojure.core/+ (1 2 3))
`(+ ~@(list 1 2 3))
; => (clojure.core/+ (1 2 3)

(defmacro code-critic
  "Phrases are courtesy Hermes Conrad from Futurama"
  [bad good]
  `(do ~@(map #(apply criticize-code %)
              [["Great squid of Madrid, this is bad code:" good]
               ["Sweet Gorilla of Manilla, this is good code:" bad]])))
(code-critic (1 + 2) (+ 1 2))

; Things to watch for


; variable capture

(def message "Good job!")
(defmacro with-mischief
  [& stuff-to-do]
  (concat (list 'let ['message "Oh, big deal!"])
          stuff-to-do))
(with-mischief
  (println "Here's how I feel about what your think you did:" message))
; => Here's how I feel about what your think you did: Oh, big deal!

; with syntax quoting

(def message "Good job!")
(defmacro with-mischief
  [& stuff-to-do]
  `(let [message "Oh, big deal!"]
     ~@stuff-to-do))

(with-mischief
  (println "Here's how I feel about that thing you did: " message))
; Exception

; possile rewrite

(defmacro without-mischief
  [& stuff-to-do]
  (let [macro-message (gensym 'message)]
    `(let [~macro-message "Oh! Big Deal!"]
       ~@stuff-to-do
       (println "I still need to say: " ~macro-message))))

(without-mischief
 (println "Here's how I feel about that thing you did: " message))

; auto-gensym
`(blarg# blarg#)
; => (blarg__11196__auto__ blarg__11196__auto__)

`(let [name# "Harry Poter"] name#)
; => (clojure.core/let [name__11200__auto__ "Harry Poter"] name__11200__auto__)


; double evaluations
(defmacro report
  [to-try]
  `(if ~to-try
    (println (quote ~to-try) "was successful:" ~to-try)
    (println (quote ~to-try) "was not successful:" ~to-try)))
(report (do (Thread/sleep 1000) (+ 1 1)))
;to-try sleep evaluated two times ; not cool, especially if you replace sleep by a transfer from your bank account

; solution
(defmacro report
  [to-try]
  `(let [result# ~to-try]
    (if result#
       (println (quote ~to-try) "was successful:" result#)
       (println (quote ~to-try) "was not successful:" result#))))
(report (do (Thread/sleep 1000) (+ 1 1)))

; Macro all the way down

(report (= 1 1))
(report (= 1 2))

; doseq

(doseq [code ['(= 1 1) '(= 1 2)]]
  (report code))

; what a macroexpand could look like: 
; (if
;  code
;  (clojure.core/println 'code "was successful:" code)
;  (clojure.core/println 'code "was not successful:" code))
;
; PROBLEM: code is not evaluated and macro expansion of report occurs before evaluation

; to solve situation...

(defmacro doseq-macro
         [macroname & args]
         `(do
            ~@(map (fn [arg] (list macroname arg)) args)))

(doseq-macro report (= 1 1) (= 1 2))
(macroexpand '(doseq-macro report (= 1 1) (= 1 2)))
