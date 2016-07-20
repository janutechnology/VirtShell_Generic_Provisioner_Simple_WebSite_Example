#!/bin/bash

echo "Installing nginx..."
sudo vs_package -i nginx

echo "Creating root directory..."
sudo mkdir -p /var/www/example.com/public_html

echo "Setting up permissions..."
sudo chown -R www-data:www-data /var/www/example.com/public_html
sudo chmod 755 /var/www

echo "Creating the page..."
sudo cp files/index.html /var/www/example.com/public_html

echo "Creating the new virtual host file..."
sudo cp files/example.com /etc/nginx/sites-available/example.com
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com
sudo rm /etc/nginx/sites-enabled/default

echo "Restarting nginx..."
sudo vs_service --restart nginx