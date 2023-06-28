include .env.docker

CONTAINER_NAME = $(PROJECT_NAME)-symfony$(SYMFONY_VERSION)-php$(PHP_VERSION)
IMAGE_NAME = php$(PHP_VERSION)-symfony

# Help command
help :
	@echo "new : Set the environment variables and create a new project"
	@echo "create : Create a new container and project from .env file (use by script)"
	@echo "reset : Reset the environment variables to the default values"


# Create a new project
new :
	@./scripts/setup-project.sh

# Create a new project from .env file (called by setup-project.sh)
create:
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker build
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker up -d --remove-orphans

	@docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*" --webapp
	@rm -f $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker-compose.override.yml
	@docker exec -it $(CONTAINER_NAME) rm -rf $(PROJECT_NAME)/.git
	@./scripts/copy-files.sh
	@docker-compose -f ./docker-compose.yml --env-file=.env.docker down --remove-orphans
	@echo "\033[1m\033[32mYour project $(PROJECT_NAME) has been successfully created on $(PATH_PROJECT) \033[0m"

# Reset the environment variables to the default values
reset :
	@./scripts/reset-env.sh

clean :
	@images=$$(docker images --filter "dangling=true" -q); \
    if [ -n "$$images" ]; then \
        docker rmi $$images --force; \
    fi
