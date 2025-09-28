FROM php:8.2-apache
COPY ./webapp /var/www/html/
RUN docker-php-ext-install mysqli