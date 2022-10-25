apt-get update
apt-get install apache2

touch /etc/apache2/sites-available/wise.yyy.com.conf

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.yyy.com
        ServerName wise.yyy.com
        ServerAlias www.wise.yyy.com

        Alias "/index.php/home" "/var/www/wise.yyy.com/home"

        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/wise.yyy.com.conf

touch /etc/apache2/sites-available/eden.wise.yyy.com.conf

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.yyy.com
        ServerName eden.wise.yyy.com
        ServerAlias www.eden.wise.yyy.com

        <Directory /var/www/eden.wise.yyy.com/public>
                Options +Indexes
        </Directory>

        <Directory /var/www/eden.wise.yyy.com/error>
                Options +Indexes
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        ErrorDocument 404 /var/www/eden.wise.yyy.com/error/404.html
</VirtualHost>' > /etc/apache2/sites-available/eden.wise.yyy.com.conf

a2ensite wise.yyy.com.conf
a2dissite 000-default.conf
a2ensite eden.wise.yyy.com.conf

service apache2 restart

mkdir /var/www/wise.yyy.com
touch /var/www/wise.yyy.com/index.php
touch /var/www/wise.yyy.com/home

echo '
<?php
        echo "Halaman PHP";' > /var/www/wise.yyy.com/index.php

echo 'Halaman home' > /var/www/wise.yyy.com/home

mkdir /var/www/eden.wise.yyy.com
touch /var/www/eden.wise.yyy.com/index.html
mkdir /var/www/eden.wise.yyy.com/public
touch /var/www/eden.wise.yyy.com/public/main.js
touch /var/www/eden.wise.yyy.com/public/init.sh
mkdir /var/www/eden.wise.yyy.com/error
touch /var/www/eden.wise.yyy.com/error/404.html

echo 'Halaman html EDEN' > /var/www/eden.wise.yyy.com/index.html
echo 'Error 404 gan.' > /var/www/eden.wise.yyy.com/error/404.html