// Basic example how CSP works in Go
// Explain pretty well how it works
// Could be interesting to add more player to see that the order
// is not always the same!

package main

import (
	"fmt"
	"time"
)

func main() {
	var ball int
	table := make(chan int)
	go player("player 1", table)
	go player("player 2", table)

	fmt.Println("Throw the ball on the table")
	table <- ball
	time.Sleep(2 * time.Second)
	<-table
	fmt.Println("Ball lost in the void!")
}

func player(name string, table chan int) {
	for {
		ball := <-table
		fmt.Println(fmt.Sprintf("%s receives the ball", name))
		time.Sleep(100 * time.Millisecond)
		fmt.Println(fmt.Sprintf("%s throws the ball to her opponent", name))
		// For 2 player, the second one gets the ball because it's the only one trying to read the channel
		// Order get random with 3 players (two reading the channel) and more
		// It's random after each call though, when running each player takes turn sequentially
		// It's because there is a FIFO queue of goroutine happening here
		table <- ball
	}
}
