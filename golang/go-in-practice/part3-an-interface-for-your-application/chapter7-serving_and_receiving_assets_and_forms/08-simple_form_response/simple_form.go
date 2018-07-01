package main

import (
	"fmt"
	"net/http"
)

func exampleHandler(w http.ResponseWriter, r *http.Request) {
	err := r.ParseForm()
	if err != nil {
		fmt.Println(err)
	}
	name := r.FormValue("name")
	fmt.Println(name)
}
