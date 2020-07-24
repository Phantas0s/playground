; As a large system with generic operations
; evolves, new types of data objects or new operations may
; be needed. For each of the three strategies—generic opera-
; tions with explicit dispatch, data-directed style, and message-
; passing-style—describe the changes that must be made to a
; system in order to add new types or new operations. Which
; organization would be most appropriate for a system in
; which new types must often be added? Which would be
; most appropriate for a system in which new operations
; must often be added?

; Explicit dispatch is not really suited for anything. It's difficult to scale.

; In message passing, the dispatch is made on the name of the operation. Therefore, it would be better suited if you need to add more operations than type.

; Data directed programming will dispatch depending on the type. I think it would be better suited if you need to add many types. Plus, we can use multiple arguments 

; **WRONG?**

; See http://wiki.c2.com/?ExpressionProblem
; See http://community.schemewiki.org/?sicp-ex-2.76

; In data direct programming, you might need to change every package installs which support the new type. If you want to add a new operation, it's easy: just add it in the good install package.

; In message passing, it's easy to add a new type. Simply create it with the operation it can do, and that's all.
; If you need to add an operation, you need to modify every types which might implement it.

; As always, modification is the problem. The best is to extend. There is the question how much the code is spread out as well, and how easy it is to find every places the code need to be changed.

; It's an interesting question.
