package main

import (
	"fmt"
	"os"
)

func main() {
	args := os.Args[1:]

	if result, err := Concat(args...); err != nil {
		fmt.Printf("error: %s\n", err)
	} else {
		fmt.Printf("concatenated string: '%s'\n", result)
	}
}
