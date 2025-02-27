#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env

    php artisan key:generate
else
    echo ".env file exists"
fi

php artisan migrate
php artisan optimize:clear
php artisan optimize

php artisan serve --port=8000 --host=0.0.0.0 --env=.env

exec docker-php-entrypoint "$@"