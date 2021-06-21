// Little demo to show the difference between buffered and unbuffered channel

// In short: any read block, for buffered or unbuffered channels.
// Writing doesn't block for buffered channel iff the channel has some space
// Writing always block for unbuffured channel if the channel is nowhere read (on another goroutine)

// It means that the only difference between make(chan bool) and make(chan bool, 1) is at the write level: the first one might block, the second won't.

// Stupid question: is make(chan bool, 0) and make(chan bool) the same? I would never write make(chan bool, 0)... but still? :D

package main

import (
	"fmt"
	"time"
)

func main() {
	bufferedChannel()
	unbuffuredChannel()
	bufferedChannelWrite()
	// unbufferedChannelWrite()
	biggerBufferedChannel()
}

func bufferedChannel() {
	c := make(chan bool, 1)
	go func() {
		time.Sleep(3 * time.Second)
		fmt.Println("In goroutine with buffured channel (size 1)")
		c <- true
	}()
	<-c // block till receive a value
	fmt.Println("Buffered channel finished (size 1)")
}

func biggerBufferedChannel() {
	c := make(chan bool, 3)
	go func() {
		time.Sleep(3 * time.Second)
		fmt.Println("In goroutine with buffured channel (size 3)")
		c <- true
	}()
	<-c // block till receive a value
	fmt.Println("Buffered channel finished (size 3)")
}

func unbuffuredChannel() {
	c := make(chan bool)
	go func() {
		time.Sleep(3 * time.Second)
		fmt.Println("In goroutine with unbuffered channel")
		c <- true
	}()
	// will block if there is not the next line (no receiver)
	<-c
	fmt.Println("unbuffered channel finished")
}

func bufferedChannelWrite() {
	c := make(chan bool, 1)
	// Doesn't block
	c <- true
	// If next line uncommented, will block - deadlock (channel full already)
	// c <- true
	fmt.Println("Finished to write to buffered channel (size 1)")
}

func unbufferedChannelWrite() {
	c := make(chan bool)
	// will block here - deadlock
	c <- true
	fmt.Println("Finished to write to unbuffered channel")
}
