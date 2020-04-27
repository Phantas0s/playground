(ns playsync.code
  (:require [clojure.core.async
             :as a
             :refer [>! <! >!! <!! go chan buffer close! thread
                     alts! alts!! timeout]]))

; Processes / Channels

; Two processes here; the current one and the go process

(def echo-chan (chan))
; (go (println (<! echo-chan))) ; Take function. When I take a message from echo-chan, print it. Process block till a message is received.
; (>!! echo-chan "ketchup") ; Put function. Give a message to echo-chan. Process block till another process take the message.
; (>!! (chan) "mustard") ; Process will block indefinitely. No process listening to that channel.

; Buffered channels


(def echo-buffer (chan 2))
(>!! echo-buffer "ketchup")
; => true
(>!! echo-buffer "ketchup")
; => true
(>!! echo-buffer "ketchup")
; Block the channel; buffer is full

(def hi-chan (chan))
(doseq [n (range 1000)]
  (go (>! hi-chan (str "hi " n))))

(thread (println (<!! echo-chan)))
(>!! echo-chan "mustard")
; => true
; => mustard

(let [t (thread "chili")]
  (<!! t))
; => "chili"
