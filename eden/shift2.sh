touch /etc/apache2/sites-available/wise.c03.com.conf

echo '
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.c03.com
        ServerName wise.c03.com
        ServerAlias www.wise.c03.com

        Alias "/index.php/home" "/var/www/wise.c03.com/index.php"
        Alias "/home" "/var/www/wise.c03.com/index.php"

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
cd /var/www/wise.c03.com

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e" -O /var/www/wise.c03.com/a && rm -rf /tmp/cookies.txt
unzip a
mv /var/www/wise.c03.com/wise/index.php /var/www/wise.c03.com
mv /var/www/wise.c03.com/wise/home.html /var/www/wise.c03.com
mv /var/www/wise.c03.com/wise/anya.jpg /var/www/wise.c03.com

rm -r wise
rm a

mkdir /var/www/eden.wise.c03.com

touch /var/www/eden.wise.c03.com/index.html
echo 'File index.html EDEN' > /var/www/eden.wise.c03.com/index.html

mkdir /var/www/eden.wise.c03.com/public

mkdir /var/www/eden.wise.c03.com/public/images
wget "https://drive.google.com/uc?export=download&id=1cX8N_RiiXu7_0HH-S-hplbqzBI6-NkGv" -O /var/www/eden.wise.c03.com/public/images/buddies.jpg
wget "https://drive.google.com/uc?export=download&id=1s99QRCigpNTfjs71EGLizmPrrT2Z5Ote" -O /var/www/eden.wise.c03.com/public/images/desmondwawklkl.sakdae
wget "https://drive.google.com/uc?export=download&id=15QKjDiqfBxIYPaYXIwprNZlVKkUvHD-7" -O /var/www/eden.wise.c03.com/public/images/eden-student.jpg
wget "https://drive.google.com/uc?export=download&id=1a5rjJ0jUzF1v_4mNMVAq3gFrJ_qw36SK" -O /var/www/eden.wise.c03.com/public/images/eden.png
wget "https://drive.google.com/uc?export=download&id=1SlysFc6F5PYwsABp0Bi8r_MzuRAPB7sj" -O /var/www/eden.wise.c03.com/public/images/edencafetariaomelette.sorry
wget "https://drive.google.com/uc?export=download&id=15_FwQOZEjgY17dGVtLAOkMphv9CcmWW0" -O /var/www/eden.wise.c03.com/public/images/elegance-ede.jpg
wget "https://drive.google.com/uc?export=download&id=1SS_GuWEvKUTn3BS3G3zhfwAnWqeBv3WV" -O /var/www/eden.wise.c03.com/public/images/not-eden.png
wget "https://drive.google.com/uc?export=download&id=1vY5C_W3wIeqDxi1eZobMTH5baQ_g4iaY" -O /var/www/eden.wise.c03.com/public/images/notedenjustmuseum.177013

mkdir /var/www/eden.wise.c03.com/public/js
wget "https://drive.google.com/uc?export=download&id=1z6nTJbi9XbPurrfhyiTMtY7T1B3p2rlQ" -O /var/www/eden.wise.c03.com/public/js/autocomplete.js
wget "https://drive.google.com/uc?export=download&id=1efCIdnpdzFj42xlFgN65YvHCnwxjBMNb" -O /var/www/eden.wise.c03.com/public/js/js.js
wget "https://drive.google.com/uc?export=download&id=1v7xPTmO4j8Fvsk7ZuEgOJhPU2kelOVm0" -O /var/www/eden.wise.c03.com/public/js/reddit.js

mkdir /var/www/eden.wise.c03.com/public/css
wget "https://drive.google.com/uc?export=download&id=17G2d5-6103o_tf3tPf-qvXB-yyuX54TH" -O /var/www/eden.wise.c03.com/public/css/bro.css
wget "https://drive.google.com/uc?export=download&id=1cCur75Xp7CEGV8wzV7qNWSGLug_JGnE4" -O /var/www/eden.wise.c03.com/public/css/edit.css
wget "https://drive.google.com/uc?export=download&id=1I3A6cdSPGZxtM6em4lylAOgx4gVLShcr" -O /var/www/eden.wise.c03.com/public/css/main.css

mkdir /var/www/eden.wise.c03.com/error
wget "https://drive.google.com/uc?export=download&id=1U5f-0RNFZe2s7ddRm27gR3kibpsEaZGa" -O /var/www/eden.wise.c03.com/error/404.html
wget "https://drive.google.com/uc?export=download&id=15rYdpMOztYC0AWNY07G3whvLCMQW8dTo" -O /var/www/eden.wise.c03.com/error/nyee.jpg

a2ensite wise.c03.com.conf
a2dissite 000-default.conf
a2ensite eden.wise.c03.com.conf

service apache2 restart