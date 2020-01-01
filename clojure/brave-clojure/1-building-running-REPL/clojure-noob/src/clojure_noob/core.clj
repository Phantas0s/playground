(ns clojure-noob.core
  (:gen-class))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "I'm a little teapot yo!")

  (do (println "no prompt here!")
      (+ 1 3))

  (defn test [name]
    str ("Hello " name))
  (test "Zelda"))
