FROM dunglas/frankenphp:sha-a910e39-php8.2

LABEL org.opencontainers.image.source=https://github.com/mumincacao/waltonphp
LABEL org.opencontainers.image.licenses="MIT"

ENV SERVER_NAME :80
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git zip mariadb-client \
    && install-php-extensions gd opcache pdo_mysql zip \
    && apt-get -y autoremove \
    && apt-get clean
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer
