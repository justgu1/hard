FROM php:8.3-fpm

ARG user
ARG uid
ARG group
ARG gid
# Install dependencies required for Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libicu-dev \
    libxml2-dev \
    libxslt1-dev \
    git \
    zip \
    ca-certificates \
    curl \
    vim \
    htop \
    wget \
    unzip \
    parallel \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd intl opcache pdo pdo_mysql xml xsl pcntl \
    && pecl install redis \
    && docker-php-ext-enable redis pcntl

# Copy custom php.ini to the container
COPY ./docker/php-fpm/php.ini /usr/local/etc/php/

RUN addgroup --gid $gid $group
RUN adduser --disabled-password --gecos '' --uid $uid --gid $gid $user

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ARG NODE_VERSION=22.11.0
ARG NODE_PACKAGE=node-v$NODE_VERSION-linux-x64
ARG NODE_HOME=/opt/$NODE_PACKAGE

ENV NODE_PATH $NODE_HOME/lib/node_modules
ENV PATH $NODE_HOME/bin:$PATH

RUN curl https://nodejs.org/dist/v$NODE_VERSION/$NODE_PACKAGE.tar.gz | tar -xzC /opt/

RUN npm install -g npm
RUN npm install -g yarn
RUN yarn config set -- --emoji true

WORKDIR /var/www/html

USER $user

RUN composer global require laravel/installer
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >>~/.bashrc