package main

// Frpm video: https://www.youtube.com/watch?v=TQRzIVekv1o
// test is nil
// test2 is an empty slice (which points to the null struct) with length and capacity 0

// Always use the form []string to initialize a slice, except if you want to make it an empty slice.

import (
	"fmt"
)

func main() {
	var test []int
	test2 := []int{}
	test3 := make([]int, 2)

	// empty struct is one place in memory representing emptyness
	// test2 has a pointer to empty struct (but not test which is nil)
	var es1 struct{}
	var es2 struct{}

	fmt.Printf("%#v\n", test)
	fmt.Printf("%#v\n", test2)
	fmt.Printf("%#v\n", test3)

	fmt.Printf("%p\n", &es1)
	fmt.Printf("%p\n", &es2)
}
