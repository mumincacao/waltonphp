FROM dunglas/frankenphp:1.14.0-php8.3.37 AS base

LABEL org.opencontainers.image.source=https://github.com/mumincacao/waltonphp
LABEL org.opencontainers.image.licenses="MIT"

ENV SERVER_NAME=:80
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git zip mariadb-client \
    && install-php-extensions gd opcache pdo_mysql zip \
    && apt-get -y autoremove \
    && apt-get clean
COPY --from=composer:2.9.7 /usr/bin/composer /usr/bin/composer

FROM base AS dev
RUN install-php-extensions pcov xdebug


FROM dunglas/frankenphp:static-builder-musl-1.14.0 AS builder

ARG PHP_VERSION=8.3.37

WORKDIR /go/src/app
RUN MIMALLOC=1 \
    PHP_VERSION=${PHP_VERSION} \
    PHP_EXTENSIONS=amqp,ast,bcmath,brotli,bz2,ctype,curl,dom,fileinfo,filter,gd,gettext,iconv,intl,ldap,lz4,mbregex,mbstring,mysqli,mysqlnd,opcache,openssl,password-argon2,parallel,pcntl,pdo,pdo_mysql,pdo_sqlite,phar,posix,readline,redis,session,shmop,simplexml,sockets,sodium,sqlite3,ssh2,sysvmsg,sysvsem,sysvshm,tokenizer,xml,xmlreader,xmlwriter,xsl,xz,zip,zlib,zstd \
    ./build-static.sh
RUN touch /tmp/.empty
RUN cd /tmp && curl --remote-name https://curl.se/ca/cacert.pem

FROM scratch AS static

LABEL org.opencontainers.image.source=https://github.com/mumincacao/waltonphp
LABEL org.opencontainers.image.licenses="MIT"

COPY --from=builder /go/src/app/dist/frankenphp-linux-x86_64 /frankenphp
COPY --from=builder /tmp/.empty /tmp/.empty
COPY --from=builder /tmp/cacert.pem /etc/ssl/cert.pem

EXPOSE 80 443
ENTRYPOINT ["/frankenphp"]
CMD ["php-server", "--root", "/app/public"]
