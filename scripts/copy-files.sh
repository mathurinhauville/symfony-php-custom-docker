#!/bin/bash

source .env 

# generate .env file for the project
echo "" > .env.tmp
echo "###> docker configuration ###" >> .env.tmp
echo PATH_CURRENT_PROJECT=. >> .env.tmp
echo PROJECT_NAME=${PROJECT_NAME} >> .env.tmp
echo SYMFONY_VERSION=${SYMFONY_VERSION} >> .env.tmp
echo PHP_VERSION=${PHP_VERSION} >> .env.tmp
echo PORT_HOST=${PORT_HOST} >> .env.tmp
echo "###< docker configuration ###" >> .env.tmp
echo "" >> .env.tmp
echo "###> mysql configuration ###" >> .env.tmp
echo "MYSQL_SERVER_VERSION=${MYSQL_SERVER_VERSION}" >> .env.tmp
echo "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" >> .env.tmp
echo "###< mysql configuration ###" >> .env.tmp
echo "" >> .env.tmp
echo "###> phpmyadmin configuration ###" >> .env.tmp
echo "PHPMYADMIN_VERSION=${PHPMYADMIN_VERSION}" >> .env.tmp
echo "###< phpmyadmin configuration ###" >> .env.tmp

# move the .env file into the project
cat .env.tmp >> ${PATH_PROJECT}/${PROJECT_NAME}/.env
rm .env.tmp

sed -i '' "s|^DATABASE_URL=.*|DATABASE_URL=\"mysql://root:${MYSQL_ROOT_PASSWORD}@mysql:3306/app?serverVersion=${MYSQL_SERVER_VERSION}\&charset=utf8mb4\"|" ${PATH_PROJECT}/${PROJECT_NAME}/.env

# copy the Dockerfile into the project
cp -r bin ${PATH_PROJECT}/${PROJECT_NAME}
# copy the docker-compose.yml into the project
cp docker-compose.yml ${PATH_PROJECT}/${PROJECT_NAME}
# copy the Makefile into the project
cp Makefile.post ${PATH_PROJECT}/${PROJECT_NAME}/Makefile
# copy the README into the project
cp README.md.post ${PATH_PROJECT}/${PROJECT_NAME}/README.md