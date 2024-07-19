package main

import (
	"database/sql"
	"log"

	"github.com/Hain2000/simplebank/api"
	db "github.com/Hain2000/simplebank/db/sqlc"
	"github.com/Hain2000/simplebank/util"
	_ "github.com/lib/pq"
)


func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot create serverr:", err)
	}
	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}