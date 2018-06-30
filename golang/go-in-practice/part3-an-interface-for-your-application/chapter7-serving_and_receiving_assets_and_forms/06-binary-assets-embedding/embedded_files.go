// This use go.rice.
// The command rice embedded_files.go must be run before go build.
// The command line will attach a virtual filesystem with the file in it to the go binary.
// os.Walk is used, which doesn't walk symlinks
// No need external files anymore
package main

import (
	"net/http"

	rice "github.com/GeertJohan/go.rice"
)

func main() {
	box := rice.MustFindBox("../files")
	httpbox := box.HTTPBox()
	http.ListenAndServe(":8080", http.FileServer(httpbox))

	// Can embed templates
	// box := rice.MustFindBox("templates")
	// templateString, err := box.String("example.html")
	// if err != nil {
	// 	log.Fatal(err)
	// }
}
