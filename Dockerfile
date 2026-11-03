FROM php:8.3-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends libonig-dev \
    && docker-php-ext-install -j"$(nproc)" mbstring pdo_mysql \
    && a2enmod headers rewrite setenvif \
    && rm -rf /var/lib/apt/lists/*

COPY docker/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY docker/render-entrypoint.sh /usr/local/bin/render-entrypoint
COPY php-production.ini /usr/local/etc/php/conf.d/production.ini
RUN chmod +x /usr/local/bin/render-entrypoint

WORKDIR /var/www/html
COPY . .

ENV PORT=10000
EXPOSE 10000

ENTRYPOINT ["/usr/local/bin/render-entrypoint"]
CMD ["apache2-foreground"]
