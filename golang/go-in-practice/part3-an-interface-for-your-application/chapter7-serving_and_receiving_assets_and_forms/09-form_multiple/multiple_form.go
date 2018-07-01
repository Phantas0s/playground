package main

import (
	"fmt"
	"net/http"
)

func exampleHandler(w http.ResponseWriter, r *http.Request) {
	maxMemory := 16 << 20
	err := r.ParseMultipartForm(int64(maxMemory))
	if err != nil {
		fmt.Println(err)
	}
	for _, v := range r.PostForm["names"] {
		fmt.Println(v)
	}
}
