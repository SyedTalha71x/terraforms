#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Hello, World!" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
sudo systemctl status nginx

