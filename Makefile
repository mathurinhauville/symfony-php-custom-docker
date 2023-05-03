include .env

help :
	@echo "Command list :"
	@echo "new : Set the environment variables and create a new project"
	@echo "reset : Reset the environment variables to the default values"
	@echo "create : (USE BY SCRIPT) Create a new container and project"
	@echo "create-from-existing-image : (USE BY SCRIPT) Create a new project from an existing image"

new :
	@./script/setup-project.sh

create :
	docker-compose -f ./docker-compose.yml build --build-arg PHP_VERSION=$(PHP_VERSION) --build-arg GIT_NAME=$(GIT_NAME) --build-arg GIT_EMAIL=$(GIT_EMAIL)
	docker-compose -f ./docker-compose.yml up -d --remove-orphans
	docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*"
	@mkdir $(PATH_PROJECT)/$(PROJECT_NAME)/docker
	@cp .copy/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker/docker-compose.yml
	@cp .env $(PATH_PROJECT)/$(PROJECT_NAME)/docker/.env
	@cp -R php-symfony $(PATH_PROJECT)/$(PROJECT_NAME)/docker/php-symfony
	@cp .copy/Makefile $(PATH_PROJECT)/$(PROJECT_NAME)/Makefile
	@docker-compose -f ./docker-compose.yml down --remove-orphans

create-from-existing-image : 
	docker-compose -f ./docker-compose-update.yml up -d --remove-orphans
	docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*"
	@mkdir $(PATH_PROJECT)/$(PROJECT_NAME)/docker
	@cp .copy/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker/docker-compose.yml
	@cp .env $(PATH_PROJECT)/$(PROJECT_NAME)/docker/.env
	@cp -R php-symfony $(PATH_PROJECT)/$(PROJECT_NAME)/docker/php-symfony
	@cp .copy/Makefile $(PATH_PROJECT)/$(PROJECT_NAME)/Makefile
	@docker-compose -f ./docker-compose.yml down --remove-orphans

reset :
	@echo PATH_PROJECT=\".\" > .env
	@echo PROJECT_NAME=\"project-symfony\" >> .env
	@echo CONTAINER_NAME=\"container-symfony-php\" >> .env
	@echo SYMFONY_VERSION=6.2 >> .env
	@echo PHP_VERSION=8.1.0 >> .env
	@echo PORT_HOST=9000 >> .env
	@echo GIT_NAME=\"Your Name\" >> .env
	@echo GIT_EMAIL=\"you@exemple.com\" >> .env
	@echo IMAGE_NAME=php-${PHP_VERSION}-symfony-${SYMFONY_VERSION} >> .env