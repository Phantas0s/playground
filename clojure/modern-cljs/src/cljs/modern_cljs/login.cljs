(ns modern-cljs.login
  (:require [domina.core :refer [by-id value set-value!]]))

(enable-console-print!)

; First try - alone

; (defn validate-form []
;   (if (and (> (count (.-value (.getElementById js/document "email"))) 0) (> count (.-value (.getElementById js/document "password"))) 0)
;   true
;   (do (js/alert "Please complete the form!")
;       false)))

; (defn init []
;   (set! (.-onsubmit (.getElementById js/document "loginForm")) validate-form))

; (init)

; Solution
; Better with let!

(defn validate-form []
  (if (and (> (count (value (by-id "email"))) 0)
           (> (count (value (by-id "password"))) 0))
    true
    (do (js/alert "Please complete the form!")
        false)))

(defn ^:export init []
  (if (and js/document
           (.-getElementById js/document))
    (let [login-form (.getElementById js/document "loginForm")]
      (set! (.-onsubmit login-form) validate-form))))

; conflict with same call in multiple file - extracted in html page
; (set! (.-onload js/window) init) ; attach to the onload event - need to reload the page
