#!/bin/bash

echo "Installing nginx..."
vs_package -i nginx

echo "Creating root directory..."
mkdir -p /var/www/example.com/public_html

echo "Setting up permissions..."
nginx_user=$(grep user /etc/nginx/nginx.conf | head -1 | awk '{print $2}' | sed 's/\;//g')
chown -R $nginx_user:$nginx_user /var/www/example.com/public_html
chmod 755 /var/www

echo "Creating the page..."
cp files/index.html /var/www/example.com/public_html

echo "Creating the new virtual host file..."
if [ ! -f '/etc/nginx/sites-available' ]
then
    mkdir -p /etc/nginx/sites-available
fi

if [ ! -f '/etc/nginx/sites-enabled' ]
then
    mkdir -p /etc/nginx/sites-enabled
fi

cp files/example.com /etc/nginx/sites-available/example.com
ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com

if [ -f '/etc/nginx/sites-enabled/default' ]
then
    rm /etc/nginx/sites-enabled/default
fi

echo "Restarting nginx..."
vs_service --restart nginx