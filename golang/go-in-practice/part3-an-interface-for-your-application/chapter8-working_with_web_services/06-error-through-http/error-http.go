package main

import "net/http"

func displayError(w http.ResponseWriter, r *http.Request) {
	http.Error(w, "An Error Occured", http.StatusForbidden)
}

func main() {
	http.HandleFunc("/", displayError)
	http.ListenAndServe(":8080", nil)
}
