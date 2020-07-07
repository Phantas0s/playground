# Berkeley CS61 (2011)

## For Vim users

For Vim users: `gf` to go to file, `gx` to follow link.

For opening *vol1* and *vol2*: `gf` then `!firefox %`

## Resources

* [Berkeley CS61](https://github.com/theurere/berkeley_cs61a_spring-2011_archive)
    * [Fork](https://github.com/Phantas0s/berkeley_cs61a_spring-2011_archive)
* [CS61 attempt](https://github.com/labria/cs61a)
    * [Fork](https://github.com/Phantas0s/cs61a)

## Course Reader

* [Vol. 1](./course/reader/vol1.html)

* [Lecture notes](./course/reader/notes.pdf)
* [Homework](./course/reader/nodate-hw.pdf)
* [Lab assignments](./course/reader/nodate-labs.pdf)

* [Project 1](./course/reader/nodate-21.pdf)

* [Project 1 Code](./course/reader/twenty-one.scm)
* Project 2 - All exercises from SICP section 2.2.4

* [Midterm 1-1](./course/reader/mt1-1.pdf)
* [Midterm 1-2](./course/reader/mt1-2.pdf)
* [Midterm 1-3](./course/reader/mt1-3.pdf)

* [Vol. 2](./course/reader/vol2.html)

* [Solutions homework/projects from another student](https://github.com/Phantas0s/cs61a-sp11)

## Additional Files

From [cs61a library](https://inst.cs.berkeley.edu/~cs61a/sp09/library/)

* [Library](./course/library)

## Using Racket

### Other

#### Racket package
* [Planet Racket](https://planet.racket-lang.org/)
* [Simply scheme](https://planet.racket-lang.org/package-source/dyoo/simply-scheme.plt/2/2/planet-docs/manual/index.html)

#### Sources

* [Simply scheme](./scheme) # From ftp://ftp.cs.berkeley.edu/pub/scheme

### Package to install

* `raco pkg install --auto berkeley`
* `raco pkg install --auto planet-dyoo-simply-scheme1`

You might need to require the package berkeley from the REPL.

`(require berkley)`

## Simply Scheme

* `racket -i -p dyoo/simply-scheme -l xrepl`
