package main

import (
	"fmt"
	"runtime"
)

func main() {
	first()
}

func first() {
	second()
}

func second() {
	buf := make([]byte, 1024)
	runtime.Stack(buf, false)
	fmt.Printf("Trace:\n %s\n", buf)
}
