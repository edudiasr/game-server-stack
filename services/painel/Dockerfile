FROM composer:2 AS vendor
WORKDIR /app
COPY --from=src composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --no-progress --prefer-dist --optimize-autoloader --ignore-platform-reqs --no-scripts --no-autoloader
COPY --from=src src ./src
RUN composer dump-autoload --no-dev --optimize

FROM php:8.4-apache
RUN docker-php-ext-install pdo_mysql \
 && a2enmod headers \
 && sed -ri 's#DocumentRoot /var/www/html#DocumentRoot /var/www/painel/public#' /etc/apache2/sites-available/000-default.conf \
 && printf '<Directory /var/www/painel/public>\n  AllowOverride None\n  Require all granted\n  FallbackResource /index.php\n</Directory>\nServerName painel\nServerTokens Prod\nServerSignature Off\n' > /etc/apache2/conf-enabled/painel.conf \
 && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/painel
COPY --from=vendor /app/vendor ./vendor
COPY --from=src src ./src
COPY --from=src public ./public
COPY --from=src templates ./templates
COPY --from=src migrations ./migrations
COPY --from=src bin ./bin
COPY --from=src scripts ./scripts
COPY entrypoint.sh /usr/local/bin/painel-entrypoint
RUN chmod +x /usr/local/bin/painel-entrypoint bin/console && mkdir -p var && chown www-data var

ENTRYPOINT ["painel-entrypoint"]
CMD ["apache2-foreground"]
