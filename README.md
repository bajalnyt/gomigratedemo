## Go-migrate demo

A quick demo of the [gomigrate](https://github.com/golang-migrate/migrate) tool to show how it can be used to manage schema. This example uses docker for postgres, and a go program that imports the `golang-migrate` library to manage migrations (instead of using its CLI).

## Start postgres container

```
docker run -d \
	--name some-postgres \
	-p 5432:5432 \
	-e POSTGRES_DB=gomigratedemo \
	-e POSTGRES_PASSWORD=mysecretpassword \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v /Users/211008/data:/var/lib/postgresql/data \
	postgres
```

## psql

* `\l` : List all databases
* `\c postgres` : Switch to using db named postgres
* `\dt` : List tables. 
* `\d accounts` (We can use this to verify if our schema ran correctly further down)


## Create migrations

Install the go-migrate cli using homebrew: `brew install golang-migrate`.

Run the following command to create a new migration (Already present in this repo). It will create an up file and a down file in the `db/migrations` folder:

`migrate create -ext sql -dir db/migrations -seq create_account_table`

(Alternately, use the make command `make create-migration seq=create_account_table`)

## Execute the program

`go run main.go`

(Alternately, use the make command `make run-migrate`)

At the PSQL prompt, we should now see the new table created.
```
postgres=# \d accounts
 user_id    | integer                     |           | not null | nextval('accounts_user_id_seq'::regclass)
 username   | character varying(50)       |           | not null |
 password   | character varying(50)       |           | not null |
 email      | character varying(255)      |           | not null |
 created_on | timestamp without time zone |           | not null |
 last_login | timestamp without time zone |           |          |
 ```
