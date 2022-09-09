setup:
	cp .envrc.example .envrc
	yarn install

dev:
	npm run dev

build:
	go mod tidy
	CC=x86_64-linux-musl-gcc CXX=x86_64-linux-musl-g++ GOARCH=amd64 GOOS=linux CGO_ENABLED=1 go build -ldflags "-linkmode external -extldflags -static" -o bin/import import.go

import:
	sqlite3 -init db/schema.sql db/production.db .quit
	bin/import

run:
	sqlite3 -init db/schema.sql db/production.db .quit
	go run import.go
