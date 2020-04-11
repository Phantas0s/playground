; Brews for the Brave and True

; At the beginning of this chapter, I revealed a dream: to find some kind of drinkable that, once ingested, would temporarily give me the power and temperament of an ’80s fitness guru, freeing me from a prison of inhibition and self-awareness. I’m sure that someone somewhere will someday invent such an elixir, so we might as well get to work on a system for selling this mythical potion. Let’s call this hypothetical concoction the Brave and True Ale. The name just came to me for no reason whatsoever.

; Before the orders come pouring in (pun! high-five!), we’ll need to have some validation in place. This section shows you a way to do this validation functionally and how to write the code that performs validations a bit more concisely using a macro you’ll write called if-valid. This will help you understand a typical situation for writing your own macro. If you just want the macro definition, it’s okay to skip ahead to “if-valid” on page 182.

; Validation

; Order details representation

(def order-details
  {:name "Mitchard Blimmons"
   :email "mitchard.blimmonsgmail.com"}) ; invalid email address

; how validation should look like
; (validate order-details order-details-validation)
; => {: email ["Your email address doesn't look like an email address"]}

; error message for each validation
(def order-details-validation
  {:name
   ["Please enter a name" not-empty]
   :email
   ["Please enter an email address" not-empty

    "Your email address doesn't look like an email address"
    #(or (empty? %) (re-seq #"@" %))]})

(defn error-message-for
  "Return a seq of error messages"
  [to-validate message-validators-pairs]
  (map first (filter #(not ((second %) to-validate))
                     (partition 2 message-validators-pairs))))
(error-message-for "" ["Please enter a name" not-empty])
; => ("Please enter a name")

(defn validate
  "Returns a map with a vector of errors for each key"
  [to-validate validations]
  (reduce (fn [errors validation]
            (let [[fieldname validation-check-groups] validation
                  value (get to-validate fieldname)
                  error-messages (error-message-for value validation-check-groups)]
              (if (empty? error-messages)
                errors
                (assoc errors fieldname error-messages))))
          {}
          validations))
(validate order-details order-details-validation)

; Validation would be used like that

(let [errors (validate order-details order-details-validation)]
  (if (empty? errors)
    (println :success)
    (println :failure errors)))

; ... but always need to repeat it. Need an abstraction!
; Could do that

(defn if-valid
  [record validations success-code failure-code]
  (let [errors (validate record validations)]
    (if (empty? errors)
      success-code
      failure-code)))

; ... but success code and failure code would be evaluated. We need a macro.

(defmacro if-valid
  "Handle validation more concisely"
  [to-validate validations errors-name & then-else]
  `(let [~errors-name (validate ~to-validate ~validations)]
     (if (empty? ~errors-name)
       ~@then-else)))

(macroexpand
 '(if-valid order-details order-details-validations my-error-name
            (println :success)
            (println :failure my-error-name)))
; => (let* [my-error-name (peg-thing.core/validate order-details order-details-validations)] (if (clojure.core/empty? my-error-name) (println :success) (println :failure my-error-name)))

(defmacro when-valid
  [to-validate validations & then]
  `(let [errors (validate ~to-validate ~validations)]
  (when empty? errors
    ~@then)))

(when-valid order-details order-details-validation
 (println "It's a success!")
 (println :success))
