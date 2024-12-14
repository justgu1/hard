FROM php:8.3-fpm

# Set user and group to use when running the container
ARG USER
ARG UID
ARG GROUP
ARG GID

# Set Node.js version
ARG NODE_VERSION=22.12.0
ARG NODE_PACKAGE=node-v$NODE_VERSION-linux-x64
ARG NODE_HOME=/opt/$NODE_PACKAGE

# Add user and group
RUN addgroup --gid $GID $GROUP
RUN adduser --disabled-password --gecos '' --uid $UID --gid $GID $USER

# Install dependencies required for Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libicu-dev \
    libxml2-dev \
    libxslt1-dev \
    zip \
    ca-certificates \
    curl \
    unzip \
    parallel \
    mariadb-client \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd intl opcache pdo pdo_mysql  xml xsl pcntl zip \
    && pecl install redis \
    && docker-php-ext-enable redis pcntl 

# Clean up for smaller image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom php.ini to the container
COPY ./docker/php-fpm/php.ini /usr/local/etc/php/

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set Node.js environment variables
ENV NODE_PATH $NODE_HOME/lib/node_modules
ENV PATH $NODE_HOME/bin:$PATH

# Install Node.js
RUN curl https://nodejs.org/dist/v$NODE_VERSION/$NODE_PACKAGE.tar.gz | tar -xzC /opt/

# Install NPM and Yarn
RUN npm install -g npm
RUN npm install -g yarn
RUN yarn config set -- --emoji true

# Set working directory
WORKDIR /var/www

# Run the container as the user
USER $USER

# Install Laravel Installer
RUN composer global require laravel/installer
ENV PATH="$PATH:/home/${USER}/.config/composer/vendor/bin"
