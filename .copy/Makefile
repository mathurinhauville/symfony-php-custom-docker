include .env

CONTAINER_NAME = $(PROJECT_NAME)-symfony$(SYMFONY_VERSION)-php$(PHP_VERSION)
IMAGE_NAME = symfony/php$(PHP_VERSION):latest

help:
	@echo "start : Create the container and start the server"
	@echo "stop : Erase the container"
	@echo "restart : Restart the project"
	@echo "shell : Open the shell of the container"

start :
	@docker images --quiet $(IMAGE_NAME) > .tmp
	@if [ -s .tmp ]; then \
        docker-compose -f ./docker-compose.from-image.yml --env-file .env up -d --remove-orphans ; \
    else \
        docker-compose -f ./docker-compose.yml --env-file .env build --build-arg PHP_VERSION=$(PHP_VERSION) ; \
		docker-compose -f ./docker-compose.yml --env-file .env up -d --remove-orphans ; \
    fi
	@rm -f .tmp
	@echo "\033[34mStarting server...\033[0m"
	@docker exec $(CONTAINER_NAME) symfony server:start -d > /dev/null 2>&1
	@echo "\033[32mServer started on http://localhost:$(PORT_HOST)\033[0m"

stop :
	@docker-compose -f ./docker-compose.yml down --remove-orphans

restart : stop start

shell :
	@docker exec -it $(CONTAINER_NAME) /bin/bash
