package main

import (
	"log/syslog"
)

func main() {
	logger, err := syslog.New(syslog.LOG_LOCAL3, "test programming go ")
	if err != nil {
		panic("Cannot attach to syslog")
	}
	defer logger.Close()

	logger.Debug("Debug message.")
	logger.Notice("Notice message.")
	logger.Warning("Warning message.")
	logger.Alert("Alert message.")
}
