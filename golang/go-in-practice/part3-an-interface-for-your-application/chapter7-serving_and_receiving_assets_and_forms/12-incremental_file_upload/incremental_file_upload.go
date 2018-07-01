package main

import (
	"bytes"
	"fmt"
	"html/template"
	"io"
	"net/http"
	"os"
)

func fileForm(w http.ResponseWriter, r *http.Request) {
	if r.Method == "GET" {
		t, _ := template.ParseFiles("file.html")
		t.Execute(w, nil)
	} else {
		mr, err := r.MultipartReader()
		if err != nil {
			panic("Failed to read multipart message")
		}

		values := make(map[string][]string)
		maxValuesBytes := int64(10 << 20) // 10 Mbytes
		for {
			part, err := mr.NextPart()
			if err == io.EOF {
				break
			}

			name := part.FormName()
			if name == "" {
				continue
			}

			filename := part.FileName()
			var b bytes.Buffer
			if filename == "" { // Distinguish between file and text field
				n, err := io.CopyN(&b, part, maxValuesBytes)
				if err != nil && err != io.EOF {
					fmt.Fprint(w, "Error processing form")
					return
				}

				// Using a byte counter, makes sure the total size of text fields isn’t too large
				maxValuesBytes -= n
				if maxValuesBytes == 0 {
					msg := "multipart message too large"
					fmt.Fprintf(w, msg)
					return
				}
				values[name] = append(values[name], b.String())
				continue
			}
			// Alternative such as cloud storage can be used here... this is the whole of going that low level in fact
			dst, err := os.Create("/tmp/" + filename)
			defer dst.Close()
			if err != nil {
				return
			}
			for {
				buffer := make([]byte, 100000)
				cBytes, err := part.Read(buffer)
				if err == io.EOF { // for End Of File
					break
				}
				dst.Write(buffer[0:cBytes])
			}
		}
		fmt.Fprint(w, "Upload complate")
	}
}
