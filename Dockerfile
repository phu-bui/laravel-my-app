FROM alpine

ENV \
  APP_DIR="/app" \
  APP_PORT="85"

# the "app" directory (relative to Dockerfile) containers your Laravel app...
COPY app/ $APP_DIR

RUN apk add --update \
    curl \
    php \
    php-opcache \
    php-openssl \
    php-pdo \
    php-json \
    php-phar \
    php-dom \
    && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/bin --filename=composer

RUN composer install

WORKDIR $APP_DIR
CMD php artisan serve --host=0.0.0.0 --port=$APP_PORT
