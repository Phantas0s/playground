;; create main project namespace

(ns modern-cljs.core)

;; enable cljs to print to the JS console of the browser
(enable-console-print!)

;; print to the console
(println "Hello you damn world!")

(println "HELLO")

(js/console.log "Hello from CLJS")
(js/console.log (js/document.getElementById "loginForm"))

(.log js/console "Syntaxic sugar")
(.-value (.getElementById js/document "email"))
(set! (.-value (.getElementById js/document "email")) "thisIsWeak")
(count (.-value (.getElementById js/document "email")))

