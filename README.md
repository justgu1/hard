# PHP Hard - Docker Environment

> **Work in Progress**  
> This project is still under development. Some features may be incomplete or subject to change.
> Currently, `Hard` is supported on Linux OS. For Windows users, it can be run using WSL (Windows Subsystem for Linux).

## Overview

`PHP Hard` is a Docker-based environment designed to streamline the development and management of Laravel projects. It comes with pre-configured services like PHP, Composer, Node.js, Yarn, and more, enabling you to easily manage your application and its dependencies in a containerized environment.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
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

Once Docker is set up, run the following command to install `PHP Hard`:

```bash
bash <(wget -q -O - https://raw.githubusercontent.com/clebsonsh/hard/refs/heads/main/install.sh)
```

---

## Configuration

`PHP Hard` offers configuration options with reasonable defaults, easily customizable to fit your needs. Modify the settings in `~/.hard/.env` to suit your preferences.

- `WWW_PATH`: The directory where your projects are located. Default: `~/hard`
- `QUEUE_COMMAND`: Command to run your application queues. Default: `queue:work`
  - Can be changed to `queue:work --tries=3`, for example.
  - If you prefer to run Horizon, you can change it to `horizon`.
- `DB_CONNECTION`: The type of database to use. Default: `mysql`
  - Can be changed to `pgsql` if you prefer to use PostgreSQL.
  - Currently, `Hard` supports both MySQL and PostgreSQL.
- `DB_USERNAME`: Database user. Default: `root`
- `DB_PASSWORD`: Database password. Default: `password`
- `AWS_ACCESS_KEY_ID`: Minio user. Default: `root`
- `AWS_SECRET_ACCESS_KEY`: Minio password. Default: `password`

---

## Docker Commands

These commands allow you to manage the Docker containers:

- `hard up`: Start the Docker environment.
- `hard up -d`: Start the Docker environment in detached mode (background).
- `hard down`: Stop the environment and shut down all containers.
- `hard restart`: Restart the environment (containers).
- `hard ps`: Display the status of all containers.
- `hard bash`: Start a shell session within the app container.

---

## Laravel Commands

These commands help you interact with the Laravel application using Docker:

- `hard laravel ...`: Run Laravel commands.
  - Example: `hard laravel new awesome-project` to create a new project inside the `WWW_PATH` directory.

---

## Artisan Commands

Use these commands to interact with Laravel's Artisan CLI tool:

- `hard [project] artisan ...`: Run Artisan commands inside the container.
  - Example: `hard awesome-project artisan migrate` to run the migrations for the `awesome-project`.

---

## PHP Commands

Use these commands to run PHP scripts or check the PHP version:

- `hard [project] php ...`: Run a PHP command or script inside the container.
  - Example: `hard awesome-project php artisan migrate` to run the migrations for `awesome-project`.

---

## Composer Commands

These commands allow you to manage dependencies and run Composer commands within the container:

- `hard [project] composer ...`: Run Composer commands inside the container.
  - Example: `hard awesome-project composer require laravel/sanctum` to install a package.

---

## Node Commands

Execute Node.js commands within the container:

- `hard [project] node ...`: Run any Node.js command.
  - Example: `hard awesome-project node --version` to check the Node.js version.

---

## NPM Commands

Run NPM commands within the container to manage JavaScript dependencies:

- `hard [project] npm ...`: Run any NPM command.
  - Example: `hard awesome-project npm run prod` to build the production assets.

---

## Yarn Commands

Execute Yarn commands within the container:

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
