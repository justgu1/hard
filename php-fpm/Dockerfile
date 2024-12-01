FROM php:8.3-fpm

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
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd intl opcache pdo pdo_mysql xml xsl \
    && pecl install redis \
    && docker-php-ext-enable redis

# Copy custom php.ini to the container
COPY ./php-fpm/php.ini /usr/local/etc/php/

CMD ["php-fpm"]
