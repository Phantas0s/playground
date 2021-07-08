Key points of this chapter:

* Use an Array if the length is fixed, and an ArrayBuffer if the length can vary.
* Don’t use new when supplying initial values.
* Use () to access elements.
* Use for (elem <- arr) to traverse the elements.
* Use for (elem <- arr if . . .  ) . . .  yield . . .  to transform into a new array.
* Scala and Java arrays are interoperable; with ArrayBuffer, use scala.collection.

## 3.1 Fixed-Length Arrays

* `Array` type: length doesn't change

## 3.2 Variable-Length Arrays: Array Buffers

* `ArrayBuffer`

## 3.3 Traversing Arrays and Array Buffers

* Can use same code for arrays or array buffer (array lists / vectors)

## 3.4 Transforming Arrays

## 3.5 Common Algorithms

## 3.6 Deciphering Scaladoc

* Methods for array are in object ArrayOps (every Array are converted to this object)
    * `def count(p: (A) => Boolean): Int` - Function takes a predicate (function from A to boolean)
        * Example: `a.count(_ > 0)`
    * `def append(elems: A*): Unit` - Take one or more elements of type A
    * `def appendAll(xs: TraversableOnce[A]): Unit` - Any collection with the TraversableOnce trait
        * Most general trait in collections hierarchy
        * Think "any collection" (same for `Traversable` and `Iterable`
    * Seq trait require element access by integer (array, list, or string)
    ....

## 3.7 Multidimensional Arrays

* type Array[Array[Double]] for example

## 3.8 Interoperating with Java


