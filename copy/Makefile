include docker/.env

shell :
	@cd docker && docker exec -it $(CONTAINER_NAME) /bin/bash

start :
	@cd docker && docker-compose -f ./docker-compose.yml build --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg GIT_NAME=$(GIT_NAME) --build-arg GIT_EMAIL=$(GIT_EMAIL)
	@cd docker && docker-compose -f ./docker-compose.yml up -d --remove-orphans
	@cd docker && docker exec $(CONTAINER_NAME) symfony server:start -d > /dev/null 2>&1
	@echo "Server started on http://localhost:$(PORT_HOST)"

stop :
	@cd docker && docker-compose -f ./docker-compose.yml down

restart : stop start