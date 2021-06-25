import scala.io.StdIn._

// Scala program to print Hello World! 
object Geeks 
{
  // Main Method 
  def main (args: Array[String])
  {
    // this.inputOutput()
    this.loop()
  }

  def inputOutput ()
  {
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

  def loop ()
  {
    var r = 1 
    for (i <- 1 to 10) {
      r = r * i
      println(r)
    }


    for (ch <- "Hello") {
      println(ch)
    }

  }
}
