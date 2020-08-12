package cmd

import (
	"log"
	"os"

	"github.com/imrancluster/umara-store/config"
	"github.com/imrancluster/umara-store/conn"
	"github.com/spf13/cobra"
)

// RootCmd ..
var RootCmd = &cobra.Command{
	Use:   "umara-store",
	Short: "umara-store API Server",
	Long:  "umara-store API Server",
}

// Execute : Execute function to run the server
func Execute() {
	config.Init()
	conn.ConnectDB()
	conn.ConnectRedis()
	conn.ConnectSentry()

	if err := RootCmd.Execute(); err != nil {
		log.Fatalf("cannot run server. reason: %s", err.Error())
		os.Exit(1)
	}
}
