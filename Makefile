# Path: ./Makefile
#
# Commands for create a new project with docker
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

include .env

CONTAINER_NAME = $(PROJECT_NAME)-symfony$(SYMFONY_VERSION)-php$(PHP_VERSION)
IMAGE_NAME = symfony/php$(PHP_VERSION):latest

# Help command
help :
	@echo "new : Set the environment variables and create a new project"
	@echo "create : Create a new container and project from .env file (use by script)"
	@echo "reset : Reset the environment variables to the default values"


# Create a new project
new :
	@./scripts/setup-project.sh

# Create a new project from .env file (called by setup-project.sh)
create :
	@docker images --quiet $(IMAGE_NAME) > .tmp
	@if [ -s .tmp ]; then \
        docker-compose -f ./docker-compose.yml --env-file .env up -d --remove-orphans ; \
    else \
        docker-compose -f ./docker-compose.yml --env-file .env build --build-arg PHP_VERSION=$(PHP_VERSION) ; \
		docker-compose -f ./docker-compose.yml --env-file .env up -d --remove-orphans ; \
    fi
	@rm -f .tmp
	@docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*" --webapp
	@rm -f $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.override.yml
	@docker exec -it $(CONTAINER_NAME) rm -rf $(PROJECT_NAME)/.gitignore $(PROJECT_NAME)/.git
	@./scripts/copy-files.sh
	@docker-compose -f ./docker-compose.yml down --remove-orphans
	@echo "\033[1m\033[32mYour project $(PROJECT_NAME) has been successfully created on $(PATH_PROJECT) \033[0m"

# Reset the environment variables to the default values
reset :
	@./scripts/reset-env.sh