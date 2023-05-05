include .env

help:
	@echo "start : Create the container and start the server"
	@echo "stop : Erase the container"
	@echo "restart : Restart the project"
	@echo "shell : Open the shell of the container"

start :
	@docker-compose -f ./docker-compose.yml up -d --remove-orphans
	@echo "Starting server..."
	@docker exec $(CONTAINER_NAME) symfony server:start -d > /dev/null 2>&1
	@echo "Server started on http://localhost:$(PORT_HOST)"

stop :
	@docker-compose -f ./docker-compose.yml down --remove-orphans

restart : stop start

shell :
	@docker exec -it $(CONTAINER_NAME) /bin/bash
