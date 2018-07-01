package main

import (
	"fmt"
	"net/http"

	fs "github.com/Masterminds/go-fileserver"
)

func main() {
	fs.NotFoundHandler = func(w http.ResponseWriter, req *http.Request) {
		w.Header().Set("Content-Type", "text/plain; charset=utf-8")
		fmt.Fprintln(w, "The requested page could not be found. Sorry man.")
	}

	dir := http.Dir("./files")
	http.ListenAndServe(":8080", fs.FileServer(dir))
}
