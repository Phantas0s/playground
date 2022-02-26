package main

import "fmt"

func main() {
	s1 := []string{"hello", "hello", "ola", "bonjour"}
	s2 := []string{"hello", "bonjour", "bonjour"}
	fmt.Println(intersection(s1, s2))
}

func intersection(s1, s2 []string) (result []string) {
	hash := make(map[string]bool)
	for _, e := range s1 {
		hash[e] = true
	}
	for _, e := range s2 {
		if hash[e] {
			result = append(result, e)
			hash[e] = false
		}
	}

	return
}
