# PHP Hard - Docker Environment

> **Work in Progress**  
> This project is still under development. Some features may be incomplete or subject to change

## Overview

`PHP Hard` is a Docker-based environment designed to streamline the development and management of Laravel projects. It comes with pre-configured services like PHP, Composer, Node.js, Yarn, and more, enabling you to easily manage your application and its dependencies in a containerized environment.

This README provides an overview of how to use `PHP Hard` with various commands for Docker, Laravel, Artisan, PHP, Composer, Node.js, NPM, and Yarn.

## Table of Contents

- [Installation](#installation)
- [Docker Commands](#docker-commands)
- [Laravel Commands](#laravel-commands)
- [Artisan Commands](#artisan-commands)
- [PHP Commands](#php-commands)
- [Composer Commands](#composer-commands)
- [Node Commands](#node-commands)
- [NPM Commands](#npm-commands)
- [Yarn Commands](#yarn-commands)
- [Help Command](#help-command)

---

## Installation

To get started, you’ll need Docker and Docker Compose installed on your machine. If you haven't already, please follow the installation guides for [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/).

- TODO

## Docker Commands

These commands allow you to manage the Docker containers.

- `hard up`: Start the Docker environment.
- `hard up -d`: Start the Docker environment in detached mode (background).
- `hard down`: Stop the environment and shut down all containers.
- `hard restart`: Restart the environment (containers).
- `hard ps`: Display the status of all containers.
- `hard bash`: Start a shell session within the app container.

---

## Laravel Commands

These commands help you interact with the Laravel application using Docker.

- `hard laravel ...`: Run the Laravel command.
  - Example: `hard laravel new awesome-project` to run create a new project inside de WWW_PATH directory.

---

## PHP Commands

Use these commands to run PHP scripts or check the PHP version.

- `hard [project] php ...`: Run a PHP command or script inside the container.
  - Example: `hard awesome-project php artisan migrate` to run the migrations for 'awesome-project'.

---

## Composer Commands

These commands allow you to manage dependencies and run Composer commands within the container.

- `hard [project] composer ...`: Run Composer commands inside the container.
  - Example: `hard awesome-project composer require laravel/sanctum` to install a package.

---

## Node Commands

Execute Node.js commands within the container.

- `hard [project] node ...`: Run any Node.js command.
  - Example: `hard awesome-project node --version` to check the Node.js version.

---

## NPM Commands

Run NPM commands within the container to manage JavaScript dependencies.

- `hard [project] npm ...`: Run any NPM command.
  - Example: `hard awesome-project npm run prod` to build the production assets.

---

## Yarn Commands

Execute Yarn commands within the container.

- `hard [project] yarn ...`: Run any Yarn command.
  - Example: `hard awesome-project yarn prod` to build production assets.

---

## Help Command

To see a list of all available commands and get help on using them, run:

```bash
hard --help
```

This will display the full list of commands you can use to manage your Laravel project with Docker.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
