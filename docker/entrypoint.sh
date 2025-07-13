#!/usr/bin/env ash

# Start php-fpm and nginx
chown -R nginx: /var/www/html/data/polarflare/
touch /var/www/html/data/polarflare/index.php
php-fpm83
nginx -c /etc/nginx/nginx.conf

# Ready to serve?
for i in 1 2 3; do
  echo "Checking to see if PolarFlare is ready. ($i of 3)"
  curl -sm3 localhost | grep -q "Polarnova/PolarFlare"
  if [[ $? -eq 0 ]]; then
    echo "PolarFlare is ready."
    break
  fi
  sleep 2
  echo "PolarFlare is not ready."
done

echo "Access logging is disabled for production use. Tailing error logs..."
tail -f /var/log/nginx/error.log /var/log/php83/error.log
