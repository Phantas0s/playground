package main

import (
	"errors"
	"github.com/Masterminds/cookoo/safely"
	"time"
)

func message() {
	println("Inside Goroutine")
	panic(errors.New("oops"))
}

func main() {
	safely.Go(message)
	println("Outside goroutine")
	time.Sleep(100000) //To have a change to execute the goroutine
}
