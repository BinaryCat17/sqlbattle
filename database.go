package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"log"
	"os/exec"
	"path"

	_ "github.com/lib/pq"
)

type SQLBase struct {
	db *sql.DB
}

func NewSQLBase(dHost, dPort, dUser, dPassword, dName string) SQLBase {
	psqlconn := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", dHost, dPort, dUser, dPassword, dName)
	db, err := sql.Open("postgres", psqlconn)

	if err != nil {
		log.Fatalf("Unable to connect to database: %v\n", err)
		return SQLBase{}
	}

	err = db.Ping()
	if err != nil {
		log.Fatalf("Unable to ping database: %v\n", err)
	}

	return SQLBase{db}
}

func (d *SQLBase) Close() {
	d.db.Close()
}

func (d *SQLBase) ExecQuery(sqlString string, args []string) ([]string, *sql.Rows, error) {
	interfaces := make([]interface{}, len(args))
	for i := 0; i < len(args); i++ {
		interfaces[i] = args[i]
	}

	rows, err := d.db.Query(sqlString, interfaces...)
	if err != nil {
		return nil, nil, err
	}

	columns, err := rows.Columns()
	if err != nil {
		rows.Close()
		return nil, nil, err
	}
	return columns, rows, nil
}

func (db *SQLBase) ExecFile(command, method string, args []string) ([]string, *sql.Rows, error) {
	sql_path := path.Join("./", method, command+".sql")
	file, err := ioutil.ReadFile(sql_path)
	if err != nil {
		fmt.Println(err)
		return nil, nil, err
	}

	columns, rows, err := db.ExecQuery(string(file), args)
	if err != nil {
		fmt.Println(command, err)
	}
	return columns, rows, err
}

func (db *SQLBase) ExecCommand(command, method string) error {
	_, rows, err := db.ExecFile(command, method, []string{})
	if err != nil {
		return err
	}
	rows.Close()
	return nil
}

func (db *SQLBase) ExecCommandArgs(command, method string, args []string) error {
	_, rows, err := db.ExecFile(command, method, args)
	if err != nil {
		return err
	}
	rows.Close()
	return nil
}

func (db *SQLBase) ExecShell(command, method string) {
	sql_path := path.Join("./", method, command+".sql")
	cmd := exec.Command("psql", "-U", "binarycat", "-d", "shiza", "-a", "-f", sql_path)
	_, err := cmd.Output()

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	//fmt.Println(string(stdout))
}
