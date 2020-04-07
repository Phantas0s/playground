; Write the macro when-valid so that it behaves similarly to when. Here is an example of calling it: 

; (when-valid order-details order-details-validations
;  (println "It's a success!")
;  (render :success))

; When the data is valid, the println and render forms should be evaluated, and when-valid should return nil if the data is invalid.

(defmacro when-valid
  [to-validate validations & then]
  `(let [errors (validate ~to-validate ~validations)]
  (if (empty? errors)
    `(do ~then)
    nil)))

(when-valid order-details order-details-validations
 (println "It's a success!")
 (println :success))
