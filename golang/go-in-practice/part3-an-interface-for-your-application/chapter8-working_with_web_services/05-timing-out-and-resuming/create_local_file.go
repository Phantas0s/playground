package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"strconv"
	"time"
)

func main() {
	file, err := os.Create("files.zip")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer file.Close()

	location := "https://example.com/file.zip"
	err = download(location, file, 100)
	if err != nil {
		fmt.Println(err)
		return
	}

	fi, err := file.Stat()
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("Got it with %v bytes downloaded", fi.Size())
}

func download(location string, file *os.File, retries int64) error {
	req, err := http.NewRequest("Get", location, nil)
	if err != nil {
		return err
	}

	fi, err := file.Stat()
	if err != nil {
		return err
	}

	current := fi.Size()
	if current > 0 {
		start := strconv.FormatInt(current, 10)
		req.Header.Set("Range", "bytes="+start+"-")
	}

	cc := &http.Client{Timeout: 5 * time.Minute}
	res, err := cc.Do(req)
	if err != nil && hasTimedout(err) {
		if retries > 0 {
			return download(location, file, retries-1)
		}

		return err
	} else if err != nil {
		return err
	}

	if res.StatusCode < 200 || res.StatusCode >= 300 {
		errFmt := "Unsuccess HTTP request. Status: %s"
		return fmt.Errorf(errFmt, res.Status)
	}

	if res.Header.Get("Accept-Ranges") != "bytes" {
		retries = 0
	}

	_, err = io.Copy(file, res.Body)
	if err != nil && hasTimedout(err) {
		if retries > 0 {
			return download(location, file, retries-1)
		}
		return err
	} else if err != nil {
		return err
	}

	return nil
}
