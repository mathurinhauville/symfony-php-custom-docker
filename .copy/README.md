# Symfony project with custom PHP version in Docker

This project has been created from this [repository](https://github.com/mathurinhauville/symfony-php-custom-docker) by [Mathurin Hauville](https://github.com/mathurinhauville).

## Requirements
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Make command](https://www.gnu.org/software/make/)

## Usage
Help
```bash
make help
```
Create the container and lauch the Symfony server
```bash
make start
```
Erases the container
```bash
make stop
```
Restart the container (delete and create)
```bash
make restart
```
Enter in the container
```bash
make shell
```

You can change the PHP version in the .env file