## Highlights

* Fields in classes automatically come with getters and setters.
* You can replace a field with a custom getter/setter without changing the client of a class—that is the “uniform access principle.”
* Use the @BeanProperty annotation to generate the JavaBeans getXxx/setXxx methods.
* Every class has a primary constructor that is “interwoven” with the class
* definition. Its parameters turn into the fields of the class. The primary
* constructor executes all statements in the body of the class.
* Auxiliary constructors are optional. They are called this.

## 5.1 Simple Classes and Parameterless Methods

* Source file can contain multiple classes
* All of the classes have public visibility
* Use `()` for mutator method, without `()` for assessors
    * Can declare assessor without `()` - in that case *MUST* be called without `()`

## 5.2 Properties with Getters and Setters

* Getters and setters automatically created for every fields

## 5.3 Properties with Only Getters

* var
* val
* private var
    * Can be changed via methods

## 5.4 Object private field

* Method can access private field of all objects of its class

## 5.5 Bean Properties

* Many Java tools won't work with getter and setter generated
    * JavaBeans specification require getFoo and setFoo

## 5.6 Auxiliary Constructors

* Class can have as many constructors as you like
    * One *primary constructor*
    * Any number of *auxiliary constructors*


