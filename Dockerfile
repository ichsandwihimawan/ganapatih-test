FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    zip unzip \
    supervisor \
    && docker-php-ext-install pdo pdo_mysql mysqli\
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY . .
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./supervisord.conf /etc/supervisord.conf

RUN chown -R www-data:www-data /var/www/html

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

EXPOSE 9000