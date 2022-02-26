package main

import (
	"fmt"
	"testing"
	"time"
)

// Source: https://www.youtube.com/watch?v=rNSVZs66o48

func main() {
	push := make(chan string)
	pop := make(chan string)

	go Stack(push, pop)
	// go nonEmptyStack(push, pop, "")

	push <- "ACCU"
	push <- "2021"

	fmt.Println(<-pop)

	// What about popping from empty push?
}

func Stack(push <-chan string, pop chan<- string) {
	var items []string
	for {
		if depth := len(items); depth == 0 {
			items = append(items, <-push)
		} else {
			select {
			case newTop := <-push:
				items = append(items, newTop)
			case pop <- items[depth-1]:
				items = items[:depth-1]
			}
		}
	}
}

func alternativeStack(push <-chan string, pop chan<- string) {
	for {
		nonEmptyStack(push, pop, <-push)
	}
}

func nonEmptyStack(push <-chan string, pop chan<- string, top string) {
	for {
		select {
		case newTop := <-push:
			nonEmptyStack(push, pop, newTop)
		case pop <- top:
			return
		}
	}
}

func test(t *testing.T) {
	push, pop := make(chan string), make(chan string)
	go Stack(push, pop)

	select {
	case _ = <-pop:
		t.Errorf("empty stack can never be popped")
		// case <-tome.After(time.Eternity)
		// heuristic - let's say it works after a second
		// Timeout - provide a boundary - create a context
	case <-time.After(time.Second):
		t.Errorf("empty stack can be popped")
	}
}
