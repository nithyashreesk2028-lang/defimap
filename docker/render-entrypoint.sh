#!/bin/sh
set -eu

# Render provides PORT. Keep the default useful for local Docker runs too.
port="${PORT:-10000}"
case "$port" in
  ''|*[!0-9]*)
    echo "PORT must contain only digits" >&2
    exit 1
    ;;
esac

sed -i -E "s/^Listen [0-9]+$/Listen ${port}/" /etc/apache2/ports.conf
sed -i -E "s/<VirtualHost \*:[0-9]+>/<VirtualHost *:${port}>/" /etc/apache2/sites-available/000-default.conf

exec "$@"
