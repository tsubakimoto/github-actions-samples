# ベースイメージの指定
FROM php:8.2.10-apache-bullseye

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
        libicu-dev \
        libpng-dev \
        libzip-dev \
        zip \
        unzip \
        git \
        && \
    rm -rf /var/lib/apt/lists/*

# PHP拡張のインストール
RUN docker-php-ext-install \
    intl \
    pdo_mysql \
    gd \
    zip

# Composerのインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Apacheの設定
RUN a2enmod rewrite

# アプリケーションのコードをコンテナにコピー
COPY . /var/www/html

# Composerで依存関係をインストール
RUN composer install --no-interaction --no-plugins

# tmpディレクトリとlogsディレクトリのパーミッションを設定
RUN chmod -R 777 /var/www/html/tmp
RUN chmod -R 777 /var/www/html/logs

# コンテナのポートを公開
EXPOSE 80

# Apacheを起動
CMD ["apache2-foreground"]