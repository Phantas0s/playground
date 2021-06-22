# 1.1 The Scala Interpreter
# 1.2 Declaring Values and Variables

```scala
val answer = 0  // constant
var response = 0 // variable
var response: String = 0
var response: Any = 0
```

# 1.3 Commonly Used Types

* Types: Byte, Char, Short, Int, Long, Fload, Double, Boolean
* Primitive types are wrapper objects
    * Array of Int is converted to int[] in VM
* Java classes are often extended
    * java.lang.String -> StringOps
    * RichInt, RichDouble...

# 1.4 Arithmetic and Operator Overloading

* Operators are actually methods
    * `a + b` shorthand for `a.+(b)`
    * `a method b` for shorthand to `a.method(b)`
    * Don't have `++` or `--` operator

# 1.5 Calling Functions and Methods

* Scala has functions too
* Import packages
    * `scala.math._` (equivalent `math._`)
    * `_` is a wildcard
* Doesn't have static methods but *singleton objects*
    * Example: `scala.util.Random`
* Scala methods without parameters don't use parentheses

# 1.6 The apply method

* `"Hello"(4)`
    => o
    * Overloaded form of the operator `()`
    * Shortcut for "Hello".apply(4)
* Idiom to construct new objects without using "new"

# 1.7 Scaladoc

* Quite difficult for beginners

# Exercises

1. Many of them...
2. val res6: Double = 2.9999999999999996
