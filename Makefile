include .env.docker

CONTAINER_NAME = $(PROJECT_NAME)-symfony$(SYMFONY_VERSION)-php$(PHP_VERSION)
IMAGE_NAME = php$(PHP_VERSION)-symfony

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
	@cp .env.docker .env.tmp
	@sed -i '' "s|^PATH_CURRENT_PROJECT=.*|PATH_CURRENT_PROJECT=.|" .env.tmp
	@mv .env.tmp ${PATH_PROJECT}/${PROJECT_NAME}/.env.docker
	@rm -rf bin/mysql/data
	@cp -r bin ${PATH_PROJECT}/${PROJECT_NAME}
	@cp docker-compose.yml ${PATH_PROJECT}/${PROJECT_NAME}
	@cp Makefile.post ${PATH_PROJECT}/${PROJECT_NAME}/Makefile
	@cp README.md.post ${PATH_PROJECT}/${PROJECT_NAME}/README.md
	@echo "bin/mysql/data/*" >> ${PATH_PROJECT}/${PROJECT_NAME}/.gitignore
	@make setup-database

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

clean :
	@images=$$(docker images --filter "dangling=true" -q); \
    if [ -n "$$images" ]; then \
        docker rmi $$images --force; \
    fi

setup-database :
	@sed -i '' "s|^DATABASE_URL=.*|DATABASE_URL=\"mysql://root:${MYSQL_ROOT_PASSWORD}@mysql:3306/${DATABASE_NAME}?serverVersion=${MYSQL_SERVER_VERSION}\&charset=utf8mb4\"|" ${PATH_PROJECT}/${PROJECT_NAME}/.env
