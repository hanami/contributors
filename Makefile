dev:
	cp .envrc.example .envrc

build:
	go mod tidy
	GOOS=linux GOARCH=386 go build -o bin/import import.go

import:
		sqlite3 -init db/schema.sql db/production.db .quit
		bin/import

run:
		sqlite3 -init db/schema.sql db/production.db .quit
		go run import.go
