# Path: ./Makefile
#
# Makefile with commands to create a new project with symfony and docker
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

include .env

# Help command
help :
	@echo "Command list :"
	@echo "new : Set the environment variables and create a new project"
	@echo "reset : Reset the environment variables to the default values"
	@echo "create : Create a new container and project from .env file (use by script)"

# Create a new project
new :
	@./scripts/setup-project.sh

# Create a new project from .env file (called by setup-project.sh)
create :
	@if [ -s .tmp ]; then \
        docker-compose -f ./docker-compose.from-image.yml --env-file .env up -d --remove-orphans ; \
    else \
        docker-compose -f ./docker-compose.yml --env-file .env build --build-arg PHP_VERSION=$(PHP_VERSION) ; \
		docker-compose -f ./docker-compose.yml --env-file .env up -d --remove-orphans ; \
    fi
	@rm -f .tmp
	docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*" --webapp
	@rm -f $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.override.yml
	@echo "" >> $(PATH_PROJECT)/$(PROJECT_NAME)/.env 
	@cat .env >> $(PATH_PROJECT)/$(PROJECT_NAME)/.env
	@cp -r .copy/* php-symfony $(PATH_PROJECT)/$(PROJECT_NAME)
	@docker exec -it $(CONTAINER_NAME) rm -rf $(PROJECT_NAME)/.gitignore $(PROJECT_NAME)/.git
	@docker exec -it truncate -s 0 /root/.gitconfig
	@docker-compose -f ./docker-compose.yml down --remove-orphans

# Reset the environment variables to the default values
reset :
	@./scripts/setup-env.sh "PATH_PROJECT;." \
                     "PROJECT_NAME;my-project" \
                     "SYMFONY_VERSION;6.2" \
                     "PHP_VERSION;8.2" \
                     "CONTAINER_NAME;my-project-symfony6.2-PHP8.2" \
                     "IMAGE_NAME;php8.2-symfony6.2" \
                     "PORT_HOST;9000"
