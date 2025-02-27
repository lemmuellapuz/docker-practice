FROM php:8.3 AS php

RUN apt-get update -y && apt-get install -y \
    curl \
    git \
    libcurl4-gnutls-dev \
    libpq-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo pdo_mysql bcmath \
    && pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

WORKDIR /var/www
COPY . .
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

EXPOSE 8000

ENTRYPOINT [ "docker/entrypoint.sh" ]