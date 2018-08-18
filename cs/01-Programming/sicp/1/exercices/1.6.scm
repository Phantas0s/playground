; ======= my solution

; With this new form of if, the consequent and alternative will be evaluated as well as the predicate.

; Since the alternative has a recursion the program will never stop

; ======= solution found on internet

; The default if statement is a special form which means that even when an interpreter follows applicative substitution, it only evaluates one of it's parameters- not both. However, the newly created new-if doesn't have this property and hence, it never stops calling itself due to the third parameter passed to it in sqrt-iter. 

