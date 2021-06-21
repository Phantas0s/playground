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


