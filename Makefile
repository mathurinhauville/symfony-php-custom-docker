include .env.docker

CONTAINER_NAME = $(PROJECT_NAME)-php

# Create a new project
new :
	@./scripts/setup-project.sh

# Create a new project from .env file (called by setup-project.sh)
create:
	@make set-php

	@docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*" --webapp

	@if [ -n "$(MYSQL_SERVER_VERSION)" ]; then \
		make set-mysql; \
	fi

	@if [ -n "$(PHPMYADMIN_VERSION)" ]; then \
		make set-phpmyadmin; \
	fi

	@rm -f $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.override.yml
	@docker exec -it $(CONTAINER_NAME) rm -rf $(PROJECT_NAME)/.git
	@cp .env.docker .env.tmp
	@sed -i '' "s|^PATH_CURRENT_PROJECT=.*|PATH_CURRENT_PROJECT=.|" .env.tmp
	@mv .env.tmp ${PATH_PROJECT}/${PROJECT_NAME}/.env.docker
	@cp -r bin ${PATH_PROJECT}/${PROJECT_NAME}
	@cp docker-compose.yml ${PATH_PROJECT}/${PROJECT_NAME}
	@cp Makefile.post ${PATH_PROJECT}/${PROJECT_NAME}/Makefile
	@cp README.md.post ${PATH_PROJECT}/${PROJECT_NAME}/README.md

	@docker-compose -f ./docker-compose.yml --env-file=.env.docker down --remove-orphans
	@echo "\033[1m\033[32mYour project $(PROJECT_NAME) has been successfully created on $(PATH_PROJECT) \033[0m"

# Reset the environment variables to the default values
reset :
	@./scripts/setup-env.sh "PATH_PROJECT;." \
                         	"PROJECT_NAME;my-project" \
                         	"TZ;UTC" \
                         	"PHP_VERSION;latest" \
                         	"SYMFONY_VERSION;6.2" \
                         	"PORT_HOST;9000" \
                         	"MYSQL_SERVER_VERSION;8.0.33" \
                         	"MYSQL_ROOT_PASSWORD;root" \
                         	"DATABASE_NAME;app" \
                         	"PHPMYADMIN_VERSION;latest" \
                         	"PATH_CURRENT_PROJECT;."

# Delete dangling images
clean :
	@images=$$(docker images --filter "dangling=true" -q); \
    if [ -n "$$images" ]; then \
        docker rmi $$images --force; \
    fi

set-php :
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker build php
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker up -d php --remove-orphans
	@make clean

set-mysql :
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker build mysql
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker up -d mysql --remove-orphans
	@make clean
	@sed -i '' "s|^DATABASE_URL=.*|DATABASE_URL=\"mysql://root:${MYSQL_ROOT_PASSWORD}@mysql:3306/${DATABASE_NAME}?serverVersion=${MYSQL_SERVER_VERSION}\&charset=utf8mb4\"|" ${PATH_PROJECT}/${PROJECT_NAME}/.env
	rm -rf bin/mysql/data

set-phpmyadmin :
	docker-compose -f ./docker-compose.yml --env-file=.env.docker build phpmyadmin
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker up -d phpmyadmin --remove-orphans
	@make clean


