# Berkeley CS61 (2011)

## For Vim users

For Vim users: `gf` to go to file, `gx` to follow link.

For opening *vol1* and *vol2*: `gf` then `!firefox %`

## Resources

* [Berkeley CS61](https://github.com/theurere/berkeley_cs61a_spring-2011_archive)
    * [Fork](https://github.com/Phantas0s/berkeley_cs61a_spring-2011_archive)
* [CS61 attempt](https://github.com/labria/cs61a)
    * [Fork](https://github.com/Phantas0s/cs61a)

* [Solutions homework/projects from another student](https://github.com/Phantas0s/cs61a-sp11)

## Course Reader

* [Syllabus](./course/reader/course_syllabus.pdf)
* [Vol. 1](./course/reader/vol1.html)

* [Lecture notes](./course/reader/notes.pdf) [OOP Above the lines](./course/reader/aboveline.pdf)
* [OOP Above the lines](./course/reader/belowline.pdf)
* [OOP Reference Manual](./course/reader/ref-man.pdf)

* [Homework](./course/reader/nodate-hw.pdf)
* [Lab assignments](./course/reader/nodate-labs.pdf)

* [Project 1](./course/reader/nodate-21.pdf)

* [Project 1 Code](./course/reader/twenty-one.scm)
* Project 2 - All exercises from SICP section 2.2.4
* [Project 3](./course/reader/nodate-adv.txt)

Project 3 is crashing badly with every scheme interpreter I tried...

```
(load "./course/library/obj.scm")
(load "./course/library/adv.scm")
(load "./course/library/tables.scm")
(load "./course/library/adv-world.scm")
(load "./course/library/small-world.scm")
```

* [Midterm 1-1](./course/reader/mt1-1.pdf)
* [Midterm 1-2](./course/reader/mt1-2.pdf)
* [Midterm 1-3](./course/reader/mt1-3.pdf)

* [Midterm 2-1](./course/reader/mt2-1.pdf)
* [Midterm 2-2](./course/reader/mt2-2.pdf)
* [Midterm 2-3](./course/reader/mt2-3.pdf)

* [Midterm 3-1](./course/reader/mt3-1.pdf)
* [Midterm 3-2](./course/reader/mt3-2.pdf)
* [Midterm 3-3](./course/reader/mt3-3.pdf)

* [Vol. 2](./course/reader/vol2.html)


## Tools

[Envdraw](./course/cs61as-library/envdraw/envdraw.html)

## Code

* To load code in racket REPL: `(load "./course/library/scheme0.scm")`
* If something doesn't work in racket, see "./course/extra/cs61as". There are alternative to many things for racket.
* To have `set-car!` and `set-cdr!`: `(require rnrs/mutable-pairs-6)`

### Interpreter

* [First version](./course/library/scheme0.scm)
* [Second version](./course/library/scheme1.scm)
* [Third version](./course/library/scheme2.scm)

### OOP

* [Implementation](./course/library/obj.scm) - Doesn't work in Racket
* [Implementation for Racket](./course/extra/cs61as/library/obj.rkt) - [Source](https://www-inst.eecs.berkeley.edu/~cs61as/library)

### Client Server

REPL needs to run from directory `cs61a`.
Can't figure out how to make it work with racket.
Tried with chez-scheme REPL but doesn't have procedure "make-socket-server"

```
(load "./course/library/im-client.scm")
(load "./course/library/im-server.scm")
(load "./course/library/im-common.scm")
```

## Using Racket

#### Racket package

* [Planet Racket](https://planet.racket-lang.org/)
* [Simply scheme package](https://planet.racket-lang.org/package-source/dyoo/simply-scheme.plt/2/2/planet-docs/manual/index.html)
* [SICP scheme](https://docs.racket-lang.org/sicp-manual/SICP_Language.html)

## STK Sources

* [Simply scheme](./simply-scheme) # From ftp://ftp.cs.berkeley.edu/pub/scheme
* [STK sources](./stk) - If you succeed to compile that on Arch Linux, please contact me or write a quick tutorial!

### Package to install

* `raco pkg install --auto berkeley`
* `raco pkg install --auto planet-dyoo-simply-scheme1`

You might need to require the package berkeley from the REPL.

`(require berkeley)`

## Running REPL with simply-scheme

* `racket -i -p dyoo/simply-scheme -l sicp --repl`
