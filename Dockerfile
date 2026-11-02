FROM php:8.3-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends libonig-dev \
    && docker-php-ext-install -j"$(nproc)" mbstring pdo_mysql \
    && a2enmod headers \
    && rm -rf /var/lib/apt/lists/*

RUN printf '%s\n' 'SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on' \
    > /etc/apache2/conf-available/render-proxy-https.conf \
    && a2enconf render-proxy-https

WORKDIR /var/www/html
COPY . .

EXPOSE 80
