touch /etc/apache2/sites-available/wise.c03.com.conf

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.c03.com
        ServerName wise.c03.com
        ServerAlias www.wise.c03.com
        Alias "/index.php/home" "/var/www/wise.c03.com/home"
        #LogLevel info ssl:warn
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/wise.c03.com.conf

touch /etc/apache2/sites-available/eden.wise.c03.com.conf

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.c03.com
        ServerName eden.wise.c03.com
        ServerAlias www.eden.wise.c03.com
        <Directory /var/www/eden.wise.c03.com/public>
                Options +Indexes
        </Directory>
        <Directory /var/www/eden.wise.c03.com/error>
                Options +Indexes
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        ErrorDocument 404 /error/404.html
</VirtualHost>' > /etc/apache2/sites-available/eden.wise.c03.com.conf

mkdir /var/www/wise.c03.com
touch /var/www/wise.c03.com/index.php
touch /var/www/wise.c03.com/home

echo '
<?php
        echo "Halaman PHP";' > /var/www/wise.c03.com/index.php

echo 'Halaman home' > /var/www/wise.c03.com/home

mkdir /var/www/eden.wise.c03.com
touch /var/www/eden.wise.c03.com/index.html
mkdir /var/www/eden.wise.c03.com/public
touch /var/www/eden.wise.c03.com/public/main.js
touch /var/www/eden.wise.c03.com/public/init.sh
mkdir /var/www/eden.wise.c03.com/error
touch /var/www/eden.wise.c03.com/error/404.html

echo 'Halaman html EDEN' > /var/www/eden.wise.c03.com/index.html
echo 'Error 404 gan.' > /var/www/eden.wise.c03.com/error/404.html

a2ensite wise.c03.com.conf
a2dissite 000-default.conf
a2ensite eden.wise.c03.com.conf

service apache2 restart
