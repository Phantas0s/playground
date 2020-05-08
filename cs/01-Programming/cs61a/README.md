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

* [Vol. 2](./course/reader/vol2.html)

## Using Racket

### Source

* [Planet Racket](https://planet.racket-lang.org/)
* [Simply scheme](https://planet.racket-lang.org/package-source/dyoo/simply-scheme.plt/2/2/planet-docs/manual/index.html)

### Package to install

* `raco pkg install --auto berkeley`
* `raco pkg install --auto planet-dyoo-simply-scheme1`

You might need to require the package berkeley from the REPL.

`(require berkley)`

## Simply Scheme

* `racket -i -p dyoo/simply-scheme -l xrepl`
