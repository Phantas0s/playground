import scala.io.StdIn._

// Scala program to print Hello World! 
object Geeks 
{
  // Main Method 
  def main (args: Array[String]): Unit = {
    // this.inputOutput()
    // this.loop()
    // this.functions()
    // this.lazyVal()
    // this.exceptions()
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
  }
}
