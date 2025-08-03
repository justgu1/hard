#!/bin/bash

echo "Installing HARD CLI..."

# reusable yes/no prompt
confirm() {
    read -p "$1 (y/N): " response
    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# check git
if ! command -v git >/dev/null; then
    echo "Git is not installed."
    if confirm "Would you like to install Git now?"; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt update && sudo apt install git -y
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install git
        else
            echo "Your OS is not supported for automatic Git installation."
            exit 1
        fi
    else
        echo "Installation cancelled. Git is required."
        exit 1
    fi
fi

# install docker if not present
if ! command -v docker >/dev/null; then
    echo "Docker is not installed."
    if confirm "Would you like to install Docker now?"; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            curl -fsSL https://get.docker.com -o get-docker.sh
            sudo sh get-docker.sh
            rm get-docker.sh
            sudo usermod -aG docker $USER
            echo "Docker installed successfully. You may need to restart your session for permissions to take effect."
        else
            echo "Automatic Docker installation not supported for this OS. Please install manually: https://docs.docker.com/get-docker/"
            exit 1
        fi
    else
        echo "Installation cancelled. Docker is required."
        exit 1
    fi
fi

# install docker compose if not present
if ! command -v docker-compose >/dev/null && ! command -v docker compose >/dev/null; then
    echo "Docker Compose is not installed."
    if confirm "Would you like to install Docker Compose now?"; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
                -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            ln -s /usr/local/bin/docker-compose ~/.local/bin/docker-compose 2>/dev/null || true
            echo "Docker Compose installed successfully."
        else
            echo "Automatic Docker Compose installation not supported for this OS. Please install manually: https://docs.docker.com/compose/install/"
            exit 1
        fi
    else
        echo "Installation cancelled. Docker Compose is required."
        exit 1
    fi
fi

# set HARD_PATH
HARD_PATH="/home/${USER}/.hard"

# check if HARD_PATH exists
if [ -d $HARD_PATH ]; then
  # pull hard repository
  cd $HARD_PATH; git pull
else
  # clone hard repository
  git clone https://github.com/clebsonsh/hard.git $HARD_PATH
fi

# copy .env.example to .env if .env 
cp --update=none $HARD_PATH/.env.example $HARD_PATH/.env

# replace USER and USER_ID in .env for the current user
sed -i "s/USER=hard/USER=$(echo $USER)/" $HARD_PATH/.env
sed -i "s/USER_ID=1001/USER_ID=$(echo $UID)/" $HARD_PATH/.env

# source .env
. $HARD_PATH/.env

echo "If you want to change the default values, please, edit the .env file in $HARD_PATH."

# check if WWW_PATH exists and create it
if [ ! -d $WWW_PATH ]; then
  mkdir -p $WWW_PATH
fi

# check if .bashrc exists and have ~/.local/bin in the PATH
if [ -f ~/.bashrc ]; then
  if ! grep -q ".local/bin" ~/.bashrc; then
    echo "export PATH=\$PATH:~/.local/bin" >>~/.bashrc
  fi
fi

# check if .zshrc exists and have ~/.local/bin in the PATH
if [ -f ~/.zshrc ]; then
  if ! grep -q ".local/bin" ~/.zshrc; then
    echo "export PATH=\$PATH:~/.local/bin" >>~/.zshrc
  fi
fi

# check if config.fish exists and have ~/.local/bin in the PATH
if [ -f ~/.config/fish/config.fish ]; then
  if ! grep -q ".local/bin" ~/.config/fish/config.fish; then
    echo "set -x PATH \$PATH ~/.local/bin" >>~/.config/fish/config.fish
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
ln -s -f -t ~/.local/bin $HARD_PATH/core/hard

# give permission
chmod +x $HARD_PATH/core/hard

echo "Hard installed successfully!"
echo "Please, restart your terminal."
