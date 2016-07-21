#!/bin/bash

echo "Installing nginx..."
sudo vs_package -i nginx

echo "Creating root directory..."
sudo mkdir -p /var/www/example.com/public_html

echo "Setting up permissions..."
nginx_user=$(grep user /etc/nginx/nginx.conf | awk '{print $2}' | sed 's/\;//g')
sudo chown -R $nginx_user:$nginx_user /var/www/example.com/public_html
sudo chmod 755 /var/www

echo "Creating the page..."
sudo cp files/index.html /var/www/example.com/public_html

echo "Creating the new virtual host file..."
if [ ! -f '/etc/nginx/sites-available' ]
then
    sudo mkdir -p /etc/nginx/sites-available
fi

if [ ! -f '/etc/nginx/sites-enabled' ]
then
    sudo mkdir -p /etc/nginx/sites-enabled
fi

sudo cp files/example.com /etc/nginx/sites-available/example.com
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
sudo rm /etc/nginx/sites-enabled/default

echo "Restarting nginx..."
sudo vs_service --restart nginx