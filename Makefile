run-migrate:
	go run main.go

create-migration:
	migrate create -ext sql -dir db/migrations -seq $(seq)
