; Memoization (also called tabulation) is a tech-
; nique that enables a procedure to record, in a local table,
; values that have previously been computed. This technique
; can make a vast difference in the performance of a program.
; A memoized procedure maintains a table in which values
; of previous calls are stored using as keys the arguments
; that produced the values. When the memoized procedure
; is asked to compute a value, it first checks the table to see
; if the value is already there and, if so, just returns that value.
; Otherwise, it computes the new value in the ordinary way
; and stores this in the table. As an example of memoization,
; recall from Section 1.2.2 the exponential process for com-
; puting Fibonacci numbers:

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

; The memoized version of the same procedure is

(define memo-fib
  (memoize
    (lambda (n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (memo-fib (- n 1))
                     (memo-fib (- n 2))))))))

; where the memoizer is defined as

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result
              (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

; Draw an environment diagram to analyze the computation
; of (memo-fib 3). Explain why memo-fib computes the n th
; Fibonacci number in a number of steps proportional to n.
; Would the scheme still work if we had simply defined memo-
; fib to be (memoize fib)?

; No it wouldn't work, because at each step of the reduction of the recursion, fib would be called instead of memo-fib and, since fib doesn't call memoize, it would do the calculation all over again. 

**GOOD?**
