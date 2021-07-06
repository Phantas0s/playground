## 2.1 Conditional Expressions

* if/else has value
    * `val s = if (x > 0) 1 else -1`
    * `x > 0 ? 1 : -1`
* Every expression has a type
    * `val s = if (x > 0) 1 else -1`
        * Type int because every branch type int
        * If both branch are different, supertype of both branches
            * See "inheritance hierarchy" (p 96)
* `if (x > 0) 1` equivalent to `if (x > 0) 1 else ()`
    * Every expression needs to yield a value in Scala
    * class Unit that has one value: `()`
        * Similar to void (it's a value saying no value though, void is literally "no value")

* Use `:paste` in REPL to paste a whole bunch of code

## 2.2 Statement Termination

* Semicolon never required (but can be added).
    * Can be used when you need to precise end of statement.
* More than one statement on single line need semicolons
    * `if (n > 0) {r = r * n; n -= 1}`
* Kernighan and ritchie brace style favored

```
if (n > 0) {
    r = r * n
    n -= 1
}
```

## 2.3 Block expressions and assignments

* Block `{}` contains sequence of expressions, result also an expression.
    * Value of block is value of last expression
    * `val distance = { val dx = x - x0; val dy = y - y0 ; sqrt(2) }`
* Assignment has no value (value of type Unit)
    * Block that end with assignment as value Unit
    * `{ n -= 1 }`
    * Can't be chained: `x = y = 1` is WRONG

## 2.4 Input and Output

* print / println / printf

```scala
import scala.io.StdIn._

val name = readLine("Your name: ")
print("Your age: ")
val age = readInt()
printf("Hello %s! Next year, you will be %d.\n", name, age + 1)
```

## 2.5 Loops

* While loop

```
while (n > 0) {
    r = r * n
    n -= 1
}
```

* No break
    * Use `scala.util.control.Breaks._`
    * Use nested functions and return
* No direct analog for the usual for loop
* Loop not that much used (use sequence and maps)

## 2.6 Advanced for Loops and for Comprehensions

* for loops are richer than language like Scala or C++
* Multiple generator separated with semicolons
* Can use multiple generators
    * A generator can have a guard (a predicate)
* Yield construct collection of value at each iteration
    * Called *for comprehension*

## 2.7 Functions

* Method operates on an object, function doesn't
    * Specify function name, parameters, and body 
    * Must specify type of all parameters
    * Don't need to specify return type if no parameters
* Use a block if function require more than one expression
    * Last expression determines the return
    * Can use return if you want (but not common in scala)
        * More like a break for a function

## 2.8 Default and Named Arguments

* Default value for argument if you don't want to give explicit value
* Can specify parameter name when calling function
    * In that case, arguments don't have to be in order

## 2.9 Variable Arguments

## 2.10 Procedures

* Special notation for a function which returns no value
* No symbol "="
    * Deprecated apparently (always return Unit)

## 2.11 Lazy Values

* Evaluation deferred till access 
    * Stream / lazy seq / and other names in Scheme / Clojure

## 2.12 Exceptions

* Same as Java or C++ or PHP
    * When exception is thrown
    * ... bubble up and search the execution handler
    * No *checked exceptions* like in Java
    * Thrown exception has a special type `Nothing`
* try catch blocks 
    * General exception comes after more specific ones

