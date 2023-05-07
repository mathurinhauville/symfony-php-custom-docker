#!/bin/bash

# Path: scripts/reset-env.sh
#
# Script to reset the environment variables
# It's called by the Makefile in the command "make reset"
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

./scripts/setup-env.sh "PATH_PROJECT;." \
                     "PROJECT_NAME;my-project" \
                     "SYMFONY_VERSION;6.2" \
                     "PHP_VERSION;8.2" \
                     "PORT_HOST;9000"