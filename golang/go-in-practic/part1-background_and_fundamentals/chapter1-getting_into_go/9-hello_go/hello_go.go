package main

import (
	"fmt"
	"net/http"
)

func hello(res http.ResponseWriter, req *http.Request) {
	fmt.Fprint(res, "Hello, my name is Matthieu The French!")
}

func main() {
	http.HandleFunc("/", hello)
	http.ListenAndServe(":4000", nil)
}
