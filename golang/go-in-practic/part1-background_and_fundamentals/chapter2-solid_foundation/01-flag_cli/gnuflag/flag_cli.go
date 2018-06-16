package main

import (
	"fmt"
	flag "github.com/juju/gnuflag"
)

var name = flag.String("name", "World", "A name to say hello to.")

var spanish bool

func init() {
	flag.BoolVar(&spanish, "spanish", false, "use Spanish language")
	flag.BoolVar(&spanish, "s", false, "Use Spanish language")
}

func main() {
	flag.Parse(true)
	flag.VisitAll(func(flag *flag.Flag) {
		format := "\t-%s: %s (Default: '%s')\n"
		fmt.Printf(format, flag.Name, flag.Usage, flag.DefValue)
	})

	if spanish == true {
		fmt.Printf("Hola %s\n", *name)
	} else {
		fmt.Printf("Hello %s\n", *name)
	}
}
