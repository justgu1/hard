#!/usr/bin/env bash

echo "Installing Hard..."

# check if git is installed
if ! command -v git; then
    echo "Git is not installed. Please, install git and try again."
    exit 1
fi

# check if docker is installed
if ! command -v docker; then
    echo "Docker is not installed. Please, install docker and try again."
    exit 1
fi

# check if docker-compose or docker compose is installed
if ! command -v docker-compose; then
    if ! command -v docker compose; then
        echo "Docker Compose is not installed. Please, install docker-compose and try again."
        exit 1
    fi
fi

# set HARD_PATH
HARD_PATH="/home/${USER}/.hard"

# check if HARD_PATH exists
if [ -d $HARD_PATH ]; then
    rm -rf $HARD_PATH
fi

# clone hard repository
git clone https://github.com/clebsonsh/hard.git $HARD_PATH

# copy .env.example to .env
cp $HARD_PATH/.env.example $HARD_PATH/.env

# check if .bashrc exists and have ~/.local/bin in the PATH
if [ -f ~/.bashrc ]; then
    if ! grep -q ".local/bin" ~/.bashrc; then
        echo "export PATH=\$PATH:~/.local/bin" >> ~/.bashrc
    fi
fi

# check if .zshrc exists and have ~/.local/bin in the PATH
if [ -f ~/.zshrc ]; then
    if ! grep -q ".local/bin" ~/.zshrc; then
        echo "export PATH=\$PATH:~/.local/bin" >> ~/.zshrc
    fi
fi

# check if config.fish exists and have ~/.local/bin in the PATH
if [ -f ~/.config/fish/config.fish ]; then
    if ! grep -q ".local/bin" ~/.config/fish/config.fish; then
        echo "set -x PATH \$PATH ~/.local/bin" >> ~/.config/fish/config.fish
    fi
fi

# check if ~/.local/bin exists
if [ ! -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
fi

# check if ~/.local/bin/hard exists
if [ -f ~/.local/bin/hard ]; then
    rm ~/.local/bin/hard
fi

# create a symbolic link to hard.sh
cp $HARD_PATH/hard.sh ~/.local/bin/hard

# give permission
chmod +x ~/.local/bin/hard

echo "Hard installed successfully!"
echo "Please, restart your terminal."
