package main

import (
	"runtime/debug"
)

func main() {
	first()
}

func first() {
	second()
}

func second() {
	debug.PrintStack()
}
