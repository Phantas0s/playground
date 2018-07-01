package main

import "net/http"

func main() {
	dir := http.Dir("./files")
	handler := http.StripPrefix("/static/", http.FileServer(dir))
	http.Handle("/static/", handler)

	http.HandleFunc("/", homePage)
	http.ListenAndServe(":8080", nil)
}

// or

func main() {
	pr := newPathResolver()
	pr.Add("GET /hello", hello)
	dir := http.Dir("./files")
	handler := http.StripPrefix("/static/", http.FileServer(dir))
	pr.Add("GET /static/*", handler.ServeHTTP)

	http.ListenAndServe(":8080", pr)
}
