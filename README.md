# WaltonPHP

[FrankenPHP](https://frankenphp.dev/) によく使うものを追加したコンテナ

## ライブラリ

- git
- zip
- mariadb-client
- Composer

## PHP 拡張機能

- gd
- opcache
- pdo_mysql
- zip
- pcov (dev のみ)
- xdebug (dev のみ)

## Static Build

scratch に実行バイナリを入れただけのため軽量だけど一部機能に制限があります。

### 利用方法

ベースイメージの `/app` ディレクトリにアプリケーションをコピーして利用します。

```dockerfile
FROM ghcr.io/mumincacao/waltonphp-static:latest

# デフォルトの公開ディレクトリは `/app/public` になります
COPY app /app
```

`--root` オプションで公開ディレクトリを変更したり `--domain` オプションでドメインを指定することもできます。

```dockerfile
FROM ghcr.io/mumincacao/waltonphp-static:latest

# 公開ディレクトリを `/var/www/html` に変更
COPY app /app
CMD ["php-server", "--root", "/var/www/html", "--domain", "example.com"]
```

`php-cli` コマンドも利用可能です。

```sh
$ docker run --rm ghcr.io/mumincacao/waltonphp-static:latest php-cli -r "echo 'Hello, WaltonPHP.';"
Hello, WaltonPHP.
```

詳しくは [FrankenPHP のドキュメント](https://frankenphp.dev/docs/embed/#using-the-binary) を参照してください。

### 組み込まれている拡張機能

- amqp
- ast
- bcmath
- brotli
- bz2
- ctype
- curl
- dom
- fileinfo
- filter
- gd
- gettext
- iconv
- intl
- ldap
- lz4
- mbregex
- mbstring
- mysqli
- mysqlnd
- opcache
- openssl
- password-argon2
- parallel
- pcntl
- pdo
- pdo_mysql
- pdo_sqlite
- phar
- posix
- readline
- redis
- session
- shmop
- simplexml
- sockets
- sodium
- sqlite3
- ssh2
- sysvmsg
- sysvsem
- sysvshm
- tokenizer
- xml
- xmlreader
- xmlwriter
- xsl
- xz
- zip
- zlib
- zstd
