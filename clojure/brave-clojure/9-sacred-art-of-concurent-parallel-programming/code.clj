;; Futures

; Use another thread
(future (Thread/sleep 4000)
        (println "I'll print after 4 seconds"))
(println "I'll print immediately")

; future executed only once, result cached
(let [result (future (println "this print once")
                     (+ 1 1))]
  (println "deref: " (deref result))
  (println "@: " @result)) ; doesn't print "this print once" again
; => this print once
; => deref:  2
; => @:  2

; Dereferencing a future will block if future is not done
(let [result (future (Thread/sleep 3000)
                     (+ 1 1))]
  (println "The result is: " @result)
  (println "It will be at least 3 seconds before I print"))

; Return 5 if future doesn't return a value after 10 miliseconds
(deref (future (Thread/sleep 1000) 0) 10 5)

(realized? (future (Thread/sleep 1000)))
; false

(let [f (future)]
  @f
  (realized? f))
; => true

;; Delays

; If this code is executed, delay is not
(def jackson-5-delay
  (delay (let [message "Just call my name and I'll be there"]
           (println "First deref:" message)
           message)))

; Result of delay by force or dereferencing
(force jackson-5-delay)

; Execute a delay after a concurent future is done
; Delay is executed only once, even if (force notify) evaluated three times
; Make sure that multiple concurent tasks don't send each time an email (help against mutual exclusion)
(def gimli-headshots ["serious.jpg" "fun.jpg" "playful.jpg"])
(defn email-user
  [email-address]
  (println "Sending headshot notication to" email-address))
(defn upload-document
  "Simulate an upload for 3second"
  [headshot]
  (Thread/sleep 3000))
(let [notify (delay (email-user "and-my-axe@gmailcom"))]
  (doseq [headshot gimli-headshots]
    (future (upload-document headshot)
            (force notify))))

;; Promises

(def my-promise (promise))
(deliver my-promise (+ 1 2))
@my-promise

; Searching some yak butter
(def yak-butter-international
  {:store "Yak Butter International"
   :price 90
   :smoothness 90})
(def butter-than-nothing
  {:store "Butter Than Nothing"
   :price 150
   :smoothness 83})
; This is the yak butter meeting our requirement
(def baby-got-yak
  {:store "Baby Got Yack"
   :price 94
   :smoothness 99})

(defn mock-api-call
  [result]
  (Thread/sleep 1000)
  result)

(defn satisfactory?
  "If the butter meets our criteria, retunr the butter, else return false"
  [butter]
  (and (<= (:price butter) 100)
       (>= (:smoothness butter) 97)
       butter))

; inneficient
(time (some (comp satisfactory? mock-api-call)
            [yak-butter-international butter-than-nothing baby-got-yak]))

; each call on separate thread
; future can only be written once
(time
  (let [butter-promise (promise)]
    (doseq [butter [yak-butter-international butter-than-nothing baby-got-yak]]
      (future (if-let [satisfactory-butter (satisfactory? (mock-api-call butter))]
                (deliver butter-promise satisfactory-butter))))
    (println "And the winner is" @butter-promise)))

; if nothing is satisfactory, thread block forever. Needs a timeout
(time
  (let [butter-promise (promise)]
    (doseq [butter [yak-butter-international butter-than-nothing]]
      (future (if-let [satisfactory-butter (satisfactory? (mock-api-call butter))]
                  (deliver butter-promise satisfactory-butter))))
    (println "And the winner is" @butter-promise)))

; Use promise to register callback

(let [ferengi-wisdom-promise (promise)]
  (future (println "Here's some Ferengi wisdom: " @ferengi-wisdom-promise))
  (Thread/sleep 100)
  (deliver ferengi-wisdom-promise "Whisper your way to success"))


;; Rolling your own queue

;; wait macro
(defmacro wait
  "Sleep `timeout` seconds before evaluating body"
  [timeout & body]
  `(do (Thread/sleep ~timeout ~@body)))

(let [saying3 (promise)]
  (future (deliver saying3 (wait 100 "Cheerio!")))
  @(let [saying2 (promise)]
     (future (deliver saying2 (wait 400 "Pip Pop!")))
     @(let [saying1 (promise)]
        (future (deliver saying1 (wait 200 "'Ello, gov'na!")))
        (println @saying1)
        saying1)
     (println @saying2)
     saying2)
  (println @saying3)
  saying3)
