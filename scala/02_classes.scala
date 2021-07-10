object Geeks 
{
  // Main Method 
  def main (args: Array[String]): Unit = {
    val myCounter = new Counter // or new Counter()
    myCounter.increment() // Mutator
    println(myCounter.current) // Assesor

    val fred = new Person
    fred.age = 21 // Calls fred.age_=(21)
    println(fred.age) // Call the method fred.age()

    var harry = new Person
    harry.age = 30
    harry.age = 21
    println(harry.age)
  }
}

class Counter {
  private var value = 0 // Field must be initialized
  def increment() { value += 1 } // Methods are public by default
  def current() = value // or def current = value - in that case MUST use current without () for calling
}

class Person {
  // Automatic getters / setters
  // Private by default under the hood
  var privateAge = 0

  // Can redefine getter and setters
  def age = privateAge
  def age_=(newValue: Int) {
    if (newValue > privateAge) privateAge = newValue
  }
}

class Message {
  // Private field (only create getter under the hood)
  val timeStamp = java.time.Instant.now
}

class CounterAccess {
  private var value = 0
  def increment() {value += 1}

  def isLess(other : CounterAccess) = value < other.value
  // Can access private field of other object
  // Works because other is also a CounterAccess object
  // private[this] var value = 0     // Cant access other objects value anymore - object private (Smalltalk style)
  // private[Coutner] var value = 0 // Only access to specific class counter
}

import scala.beans.BeanProperty

class PersonBean {
  @BeanProperty var name: String = _
}


