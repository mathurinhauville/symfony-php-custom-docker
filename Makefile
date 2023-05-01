include .env

new :
	@./script/setup-project.sh

call-by-script :
	@docker-compose -f ./docker-compose.yml build --build-arg PHP_VERSION=$(PHP_VERSION)
	@docker-compose -f ./docker-compose.yml up -d --remove-orphans
	@docker exec -it $(CONTAINER_NAME) symfony new $(PROJECT_NAME) --version="$(SYMFONY_VERSION).*"
	@mkdir $(PATH_PROJECT)/$(PROJECT_NAME)/docker
	@cp bin/docker-compose.yml $(PATH_PROJECT)/$(PROJECT_NAME)/docker/docker-compose.yml
	@cp .env $(PATH_PROJECT)/$(PROJECT_NAME)/docker/.env
	@cp -R php-symfony $(PATH_PROJECT)/$(PROJECT_NAME)/docker/php-symfony
	@cp bin/Makefile $(PATH_PROJECT)/$(PROJECT_NAME)/Makefile
	@docker-compose -f ./docker-compose.yml down