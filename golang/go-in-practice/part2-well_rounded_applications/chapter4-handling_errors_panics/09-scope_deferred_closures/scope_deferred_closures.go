package main

import "fmt"

func main() {
	// If msg is declared after the deferred function -> error (msg undefined)
	var msg string
	defer func() {
		fmt.Println(msg)
	}()

	msg = "Hello world"
}
