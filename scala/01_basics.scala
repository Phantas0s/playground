import scala.io.StdIn._
import scala.collection.immutable.StringOps
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.SortedMap

// Scala program to print Hello World! 
object Geeks 
{
  // Main Method 
  def main (args: Array[String]): Unit = {
    this.inputOutput
    this.loop
    this.functions
    this.lazyVal
    this.exceptions
    this.fixedArrays
    this.arrayBuffers
    this.maps
  }

  def inputOutput(): Unit = {
    // prints Hello World
    println("Hello World!")
    var lala: String = "lala"
    val n: Int = 1
    if (n > 0) println("Conditional!")

    val name = readLine("Your name: ")
    print("Your age: ")
    val age = readInt()
    printf("Hello %s! Next year, you will be %d.\n", name, age + 1)
  }

  def loop(): Unit = {
    var r = 1 
    // Generator <-
    for (i <- 1 to 10) {
      r = r * i
      println("First loop")
      println(s"$r ")
    }

    for (ch <- "Hello") {
      println(ch)
    }

    for (i <- 1 to 3; j <- 1 to 3) print(s"${i}i ${j}j ")
    // => 1i 1j 1i 2j 1i 3j 2i 1j 2i 2j 2i 3j 3i 1j 3i 2j 3i 3j

    for (i <- 1 to 3; j <- 1 to 3 if i != j) print((10 * i + j) + " ")
    // => 12 13 21 23 31 32

    // Definitions
    for (i <- 1 to 3; from = 4 - i; j <- from to 3) print((10 * i + j) + " ")
    // => 13 22 23 31 32 33

    // Yield - construct collection of value at each iteration
    // For comprehension
    for (i <- 1 to 10) yield i % 3
    // => val res2: IndexedSeq[Int] = Vector(1, 2, 0, 1, 2, 0, 1, 2, 0, 1)

    for (c <- "Hello"; i <- 0 to 1) yield (c + i).toChar
    // => val res3: IndexedSeq[Char] = Vector(H, I, e, f, l, m, l, m, o, p)

    // Alternative
    // for {
    //   c <- "Hello"
    //   i <- 0 to 1
    // } yield (c + i).toChar
  }

  def functions() = {
    // Must specify type of all parameters
    // Don't need to specify return type if no parameters
    def abs(x: Double) = if (x >= 0) x else -x
    abs(10)
    abs(-10)
    // => 10

    // Recursive function (need return type)
    def fac(n: Int): Int = if (n <= 0) 1 else n * fac(n - 1)

    // Default argument (similar to PHP)
    def decorate(str: String, left: String = "[", right: String = "]") = left + str + right
    decorate("lala")
    // => [lala]
    decorate("lala", "<<<", ">>>")
    // => <<<lala>>>

    // No need argument in order if named
    decorate(left = "<<<", str = "lala", right = ">>>")

    // Arbitrary number of arguments
    // Receive a param of type Seq
    def sum(args: Int*) = {
      var result = 0
      for (arg <- args) result += arg
      result
    }
    val s = sum(1, 2, 3)
    println(s)
    // => 6
    
    // wrong
    // val s = sum(1 to 3)
    // To tell compiler you want an argument sequence
    val r = sum(1 to 5: _*)
    println(r)
    // => 15

    // This syntax required for recursive definition
    // def sum(args: Int*) = {
    //   if (args.length == 0) 0
    //   else args.head + recursiveSum(args.tail : _*)
    // }

    // Procedure without "=" (apparently deprecated)
    def box(s: String): Unit = {
      val border = "-" * s.length + "--\n"
      println(s"${border}|${s}|\n${border}")
    }

    // Non deprecated (procedure always return Unit)
    // def box(s: String): Unit = {
    //   val border = "-" * s.length + "--\n"
    //   println(s"${border}|${s}|\n${border}")
    // }
  }

  def lazyVal(): Unit = {
    // Only evaluated when "words" used
    lazy val lazyWord = scala.io.Source.fromFile("./hello.scala").mkString
    println(lazyWord)
    // Evaluated as soon as word is defined
    val valWord = scala.io.Source.fromFile("./scala/hello.scala").mkString
    // Evaluated each time words is used
    def defWord = scala.io.Source.fromFile("./scala/hello.scala").mkString
  }

  def exceptions(): Unit = {
    try {
      println(this.sqrt(-1))
      println(this.sqrt(2))
    } catch {
      // general exception should come after the specific ones (like in C++)
      // Can use _ instead of e if e not needed
      case e: IllegalArgumentException => println(s"Illegal argument $e")
    } finally {
      // Let dispose of a resource
      println("finally")
      // This line throw an exception, superseeded like in Java
      // println(this.sqrt(-1))
    }
  }

  def sqrt(x: Int): Int = {
    if (x >= 0) {
      x * x
    } else {
      throw new IllegalArgumentException("x should not be negative")
    }
  }

  def fixedArrays(): Unit = {
    // Fixed length array

    // Initialized to 0
    val nums = new Array[Int](10)
    // Initialized to null
    val a = new Array[String](10)
    val strings = Array("Hello", "Welcome")
    // () to access elements
    println(strings(0))
  }

  def arrayBuffers(): Unit = {
    // Or new ArrayBuffer[Int]
    val b = ArrayBuffer[Int]()
    // Add element a the end with +=
    b += 1
    b += (2, 3, 4, 5)
    println(b)
    // Constant time
    b.trimEnd(2)
    println(b)

    // Not efficient operation (element after need to be shifted)
    b.insert(2, 2)
    println(b)
    b.remove(2)
    println(b)
    b.remove(1, 2)
    println(b)

    val a = Array(1, 2, 3)
    a.toBuffer
    b.toArray
    println(a(1))
    println(b)

    // Traversing an array
    println("\nTraversing Array")
    // Until return all number excluded upper bound
    for (i <- 0 until a.length) {
      println(i + ": " + a(i))
    }

    // Every two elements
    // Or 0.until(a.length, 2)
    println("\nTraversing Array")
    for (i <- 0 until (a.length, 2)) {
      println(i + ": " + a(i))
    }

    println((0 until a.length).reverse)

    for (item <- a) {
      println(s"traversing: ${item}")
    }

    // Transform array (create new ones)
    val c = Array(2, 3, 5, 7, 11)
    // guard (if inside for)
    val result = for (elem <- c if elem % 2 == 0) yield 2 * elem
    val result2 = c filter (_ % 2 == 0) map { 2 * _ }

    for (item <- result) {
      println(s"traversing result: ${item}")
    }
    for (item <- result2) {
      println(s"traversing result 2: ${item}")
    }

    // Want to delete all negative elements
    val d = ArrayBuffer(2, 3, 5, 7, 11, -2, 25, 82, 90)
    val indexes = for (i <- d.indices if d(i) >= 0) yield i
    for (j <- indexes.indices) d(j) = d(indexes(j))
    d.trimEnd(a.length - indexes.length)

    for (item <- d) {
      println(s"traversing d: ${item}")
    }

    println(s"Sum: ${Array(2, 3, 5).sum}")
    println(s"Max: ${Array("Mary", "had", "a", "little", "lamb").max}")

    val e = ArrayBuffer(1, 7, 2, 9)
    val eSorted = e.sortWith(_ < _)
    // val eSorted = scala.util.Sorting.quickSort(e)
    println(eSorted.mkString(" "))

    // Multidimensional array of 3 rows 4 columns
    val matrix = Array.ofDim[Double](3, 4)

    // Ragged array
    println("Triangle!")
    val triangle = new Array[Array[Int]](10)
    for (i <- triangle.indices) {
      triangle(i) = new Array[Int](i + 1)
      triangle(i)(i) = i + 1
    }

    for (i <- triangle.indices) {
      println(triangle(i).mkString)
    }
  }

  def maps(): Unit = {
    // Immutable Map[String, int]
    val scores = Map("Alice" -> 10, "Bob" -> 3, "Cindy" -> 8)
    // val scores = Map(("Alice", 10), ("Bob", 3), ("Cindy", 8))
    println(scores)

    // Mutable
    val mutable = scala.collection.mutable.Map("Alice" -> 10, "Bob" -> 3, "Cindy" -> 8)
    println(mutable)

    // Blank
    var blank = scala.collection.mutable.Map[String, Int]()
    println(blank)

    val bobScore = scores("Bob")
    println(s"Bob Score: ${bobScore}")
    // If no value, exception thrown

    // Option: either Some(value) or None
    val bobScoreOption = scores.get("Bob")
    println(bobScoreOption)

    mutable("Bob") = 10
    println(mutable("Bob"))

    mutable += ("Bob" -> 20, "Fred" -> 7)
    println(mutable)
    // Remove key Alice with its value
    mutable -= "Alice"
    println(mutable)

    // Create new map from immutable one
    val newScores = scores + ("Bob" -> 10, "Fred" -> 7)
    println(newScores)

    // Can update a var
    var varScore = Map("Bob" -> 5, "Alice" -> 6)
    varScore +=  ("Bob" -> 10, "Fred" -> 7)
    println(varScore)

    for ((k, v) <- varScore) println(s"${k} -> ${v}")
    println(varScore.keySet.mkString(" "))
    println(varScore.values.mkString(" "))

    // Reversing a map
    val newMutable = for ((k, v) <- mutable) yield (v, k)
    println(newMutable)

    // Sorted map
    // LinkedHashMap for keys in insertion order
    val sortedScores = scala.collection.immutable.SortedMap("Alice" -> 10, "Fred" -> 7, "Bob" -> 3, "Cindy" -> 8)
    println(sortedScores)
    
    // Tuples
    // Useful for functions returning more than one value
    val tuple = (1, 3.14, "Fred")
    
    // Access (1 indexed)
    println(tuple._2)
    // Better initialization
    val (first, second, third) = tuple 
    val (one, two, _) = tuple 
    println(first, second, third, one, two)

    // Using tuple to bundle value together
    val symbols = Array("<", "-", ">")
    val counts = Array(2, 10, 2)
    val pairs = symbols.zip(counts)

    println(pairs.mkString(" "))
    for ((s, n) <- pairs) print(s * n)
  }

  def classes(): Unit = {
    val myCounter = new Counter // or new Counter()
    myCounter.increment() // Mutator
    println(myCounter.current) // Assesor
  }
}
