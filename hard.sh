#!/usr/bin/env bash
# this script is inspired by Laravel Sail
# https://github.com/laravel/sail/blob/1.x/bin/sail

# Set user and group to the same values as the host user
# This way you can avoid permission issues with files created inside the container
export USER=$(whoami)
export USER_ID=$(id -u)
export GROUP=$(id -g -n)
export GROUP_ID=(id -g)

HARD_PATH="/home/${USER}/.hard"

if docker compose &> /dev/null; then
    DOCKER_COMPOSE=(docker compose -f ${HARD_PATH}/docker-compose.yml)
else
    DOCKER_COMPOSE=(docker-compose -f ${HARD_PATH}/docker-compose.yml)
fi

. $HARD_PATH/.env

# Determine if stdout is a terminal...
if test -t 1; then
    # Determine if colors are supported...
    ncolors=$(tput colors)

    if test -n "$ncolors" && test "$ncolors" -ge 8; then
        BOLD="$(tput bold)"
        YELLOW="$(tput setaf 3)"
        GREEN="$(tput setaf 2)"
        NC="$(tput sgr0)"
    fi
fi

# Function that prints the available commands...
function display_help {
    echo "Laravel Hard"
    echo
    echo "${YELLOW}docker-compose Commands:${NC}"
    echo "  ${GREEN}hard up${NC}        Start the environment"
    echo "  ${GREEN}hard up -d${NC}     Start the environment in the background"
    echo "  ${GREEN}hard down${NC}      Stop the environment"
    echo "  ${GREEN}hard restart${NC}   Restart the environment"
    echo "  ${GREEN}hard ps${NC}        Display the status of all containers"
    echo "  ${GREEN}hard bash${NC}      Start a shell session within the app container"
    echo
    echo "${YELLOW}Laravel Commands:${NC}"
    echo "  ${GREEN}hard laravel ...${NC} Run the Laravel command"
    echo "  ${GREEN}hard laravel new awesome-project${NC}"
    echo
    echo "${YELLOW}PHP Commands:${NC}"
    echo "  ${GREEN}hard [project] php ...${NC} Run a snippet of PHP code"
    echo "  ${GREEN}hard awesome-project php artisan migrate${NC}"
    echo
    echo "${YELLOW}Composer Commands:${NC}"
    echo "  ${GREEN}hard [project] composer ...${NC} Run a Composer command"
    echo "  ${GREEN}hard awesome-project composer require laravel/sanctum${NC}"
    echo
    echo "${YELLOW}Node Commands:${NC}"
    echo "  ${GREEN}hard [project] node ...${NC} Run a Node command"
    echo "  ${GREEN}hard awesome-project node --version${NC}"
    echo
    echo "${YELLOW}NPM Commands:${NC}"
    echo "  ${GREEN}hard [project] npm ...${NC} Run a npm command"
    echo "  ${GREEN}hard awesome-project npm run prod${NC}"
    echo
    echo "${YELLOW}Yarn Commands:${NC}"
    echo "  ${GREEN}hard [project] yarn ...${NC} Run a Yarn command"
    echo "  ${GREEN}hard awesome-project yarn prod${NC}"
    echo
    exit 0
}

if [ ! -f $HARD_PATH/docker-compose.yml ]; then
    echo "ERROR: Couldn't find a 'docker-compose.yml' file in the hard directory."
    exit 1
fi

if [ ! -f $HARD_PATH/.env ]; then
    echo "ERROR: Couldn't find '.env' in the hard directory."
    exit 1
fi

if [ ! -d $WWW_PATH ]; then
    echo "ERROR: Invalid 'WWW_PATH' in the hard '.env' file."
    exit 1
fi

# Proxy the "help" command...
if [ $# -gt 0 ]; then
    if [ "$1" == "help" ] || [ "$1" == "-h" ] || [ "$1" == "-help" ] || [ "$1" == "--help" ]; then
        display_help
    fi
else
    display_help
fi


case "$1" in
    up|down|build|ps|restart) YES=1;;
    *)                        YES=0;;
esac

if [ $YES = 1 ]; then
    "${DOCKER_COMPOSE[@]}" "$@"
    exit 0
fi

case "$1" in
    bash|laravel) YES=1;;
    *)            YES=0;;
esac

if [ $YES = 1 ]; then
    "${DOCKER_COMPOSE[@]}" exec app "$@"
    exit 0
fi

if [ "$1" != "" ] && [ -d $WWW_PATH/$(basename $PWD) ]; then
    PROJECT="$(basename $PWD)"

    case "$1" in
        php|composer|npm|npx|yarn) YES=1;;
        *)            YES=0;;
    esac

    if [ $YES = 1 ]; then
        "${DOCKER_COMPOSE[@]}" exec -it --workdir "/var/www/html/$PROJECT" app "$@"
        exit 0
    fi
fi

if [ "$1" != "" ] && [ -d $WWW_PATH/"$1" ]; then
    PROJECT="$1"
    shift 1

    case "$1" in
        php|composer|npm|npx|yarn) YES=1;;
        *)            YES=0;;
    esac

    if [ $YES = 1 ]; then
        "${DOCKER_COMPOSE[@]}" exec -it --workdir "/var/www/html/$PROJECT" app "$@"
        exit 0
    fi
fi

display_help
