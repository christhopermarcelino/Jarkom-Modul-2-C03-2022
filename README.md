# Laporan Resmi Praktikum Modul 2 Jaringan Komputer

Penyelesaian Soal Shift Modul 2 Jaringan Komputer 2022 <br>
Kelompok C03
- Aqil Ramadhan Hadiono - NRP 5025201261
- Christhoper Marcelino Mamahit - NRP 5025201249
- Zahra Fayyadiyati - NRP 5025201133

## Table of Contents
* [Soal 1](#soal-1)
* [Soal 2](#soal-2)
* [Soal 3](#soal-3)
* [Soal 4](#soal-4)
* [Soal 5](#soal-5)
* [Soal 6](#soal-6)
* [Soal 7](#soal-7)
* [Soal 8](#soal-8)
* [Soal 9](#soal-9)
* [Soal 10](#soal-10)
* [Soal 10](#soal-11)
* [Soal 10](#soal-12)
* [Soal 10](#soal-13)
* [Soal 10](#soal-14)
* [Soal 10](#soal-15)
* [Soal 10](#soal-16)
* [Soal 10](#soal-17)

## Soal 1
**Deskripsi:**
Terdapat 2 Client yaitu SSS, dan Garden. Semua node terhubung pada router Ostania, sehingga dapat mengakses internet 

**Pembahasan:**
Berikut ini adalah network configuration dari setiap node.

Ostania
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.11.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.11.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.11.3.1
	netmask 255.255.255.0
```

SSS
```
auto eth0
iface eth0 inet static
	address 10.11.1.2
	netmask 255.255.255.0
	gateway 10.11.1.1
```

Garden
```
auto eth0
iface eth0 inet static
	address 10.11.1.3
	netmask 255.255.255.0
	gateway 10.11.1.1
```

WISE 
```
auto eth0
iface eth0 inet static
	address 10.11.2.2
	netmask 255.255.255.0
	gateway 10.11.2.1
```

Berlint
```
auto eth0
iface eth0 inet static
	address 10.11.3.2
	netmask 255.255.255.0
	gateway 10.11.3.1
```

Eden
```
auto eth0
iface eth0 inet static
	address 10.11.3.3
	netmask 255.255.255.0
	gateway 10.11.3.1
```

Semua node client (SSS dan Garden) memiliki `nameserver 10.11.2.2 nameserver 10.11.2.3` sementara node lainnya memiliki `nameserver 192.168.122.1`

## Soal 2
**Deskripsi:**
Untuk mempermudah mendapatkan informasi mengenai misi dari Handler, bantulah Loid membuat website utama dengan akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise

**Pembahasan:**
Supaya client dapat mengakses wise.c03.com dan www.wise.c03.com, dituliskan code sebagai berikut di /etc/bind/wise/wise.c03.com.
```
;
; BIND data file for local loopback interface
;

\$TTL    604800
@       IN      SOA     wise.c03.com. root.wise.c03.com. (
                       20221024         ; Serial 
                         604800         ; Refresh
                          86400         ; Retry 
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                               IN      NS      wise.c03.com.
@                               IN      A       10.11.3.3
www                             IN      CNAME   wise.c03.com.
```
Selain itu, dibuat juga pengaturan zone sebagai berikut di /etc/bind/named.conf.local
```
zone \"wise.c03.com\" {
    type master;
    notify yes;
    also-notify { 10.11.3.2; };
    allow-transfer { 10.11.3.2; };
    file \"/etc/bind/wise/wise.c03.com\";
};
```
Terlihat bahwa IP yang tertera adalah 10.11.3.3, yakni IP Eden karena web server akan dijalankan di Eden.

## Soal 3
**Deskripsi:**
Setelah itu ia juga ingin membuat subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com yang diatur DNS-nya di WISE dan mengarah ke Eden 

**Pembahasan:**
Untuk itu, ditambahkan subdomain di /etc/bind/wise/wise.c03.com dengan menambahkan code seperti sebagai berikut.
```
eden                            IN      A       10.11.3.3
www.eden.wise.c03.com.          IN      CNAME   eden.wise.c03.com.
```

## Soal 4
**Deskripsi:**
Buat juga reverse domain untuk domain utama

**Pembahasan:**
Caranya adalah dengan membuat konfigurasi di /etc/bind/named.conf.options terlebih dahulu.
```
options {
    directory \"/var/cache/bind\";
    allow-query{any;};

    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};
```
Setelah itu, membuat zone di /etc/bind/named.conf.local
```
zone \"2.11.10.in-addr.arpa\" {
    type master;
    file \"/etc/bind/wise/2.11.10.in-addr.arpa\";
};
```
Lalu, membuat konfigurasi DNS di /etc/bind/wise/2.11.10.in-addr.arpa
```
;
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     wise.c03.com. root.wise.c03.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.11.10.in-addr.arpa.   IN      NS      wise.c03.com.
2                       IN      PTR     wise.c03.com.   ; Byte ke-4
```

## Soal 5
**Deskripsi:**
Agar dapat tetap dihubungi jika server WISE bermasalah, buatlah juga Berlint sebagai DNS Slave untuk domain utama 

**Pembahasan:**
Supaya Berlint dapat menjadi slave dari WISE, diperlukan konfigurasi zone pada Berlint
```
zone \"wise.c03.com\" {
    type slave;
    masters { 10.11.2.2; };
    file \"/var/lib/bind/wise.c03.com\";
};
```
Pada code tersebut, terlihat bahwa Berlint adalah slave dari IP 10.11.2.2 yang mana IP tersebut adalah IP dari WISE. Selain itu, ditambahkan pula konfigurasi sebagai berikut di /etc/bind/named.conf.options
```
options {
    directory \"/var/cache/bind\";
    allow-query{any;};

    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};
```

## Soal 6
**Deskripsi:**
Karena banyak informasi dari Handler, buatlah subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com yang didelegasikan dari WISE ke Berlint dengan IP menuju ke Eden dalam folder operation

**Pembahasan:**
Untuk memenuhi deskripsi tersebut, ditambahkan konfigurasi delegasi subdomain pada /etc/bind/wise/wise.c03.com.
```
ns1                             IN      A       10.11.3.2
operation                       IN      NS      ns1
```
Setelah itu, dibuat konfigurasi zone di Berlint di /etc/bind/named.conf.local
```
zone \"operation.wise.c03.com\" {
    type master;
    file \"/etc/bind/c03/operation.wise.c03.com\";
};
```
Lalu, ditambahkan konfigurasi DNS pada /etc/bind/c03/operation.wise.c03.com
```
;
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     operation.wise.c03.com. root.operation.wise.c03.com. (
                       20221024         ; Serial 
                         604800         ; Refresh
                          86400         ; Retry 
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                               IN      NS      operation.wise.c03.com.
@                               IN      A       10.11.3.3
www                             IN      CNAME   operation.wise.c03.com.
;
```
Terlihat bahwa IP yang tertera adalah 10.11.3.3, yakni IP Eden sehingga sesuai dengan permintaan soal.

## Soal 7
**Deskripsi:**
Untuk informasi yang lebih spesifik mengenai Operation Strix, buatlah subdomain melalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com yang mengarah ke Eden

**Pembahasan:**
Untuk itu, ditambahkan konfigurasi sebagai berikut di /etc/bind/c03/operation.wise.c03.com yang terletak di Berlint
```
strix                                     IN      A       10.11.3.3
www.strix.operation.wise.c03.com.         IN      CNAME   strix.operation.wise.c03.com.
```
Terlihat bahwa IP yang tertera adalah 10.11.3.3, yakni IP Eden sehingga sesuai dengan permintaan soal.

## Soal 8
**Deskripsi:**
Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver www.wise.yyy.com. Pertama, Loid membutuhkan webserver dengan DocumentRoot pada /var/www/wise.yyy.com

**Pembahasan:**  
Pada file init.sh, kami menjalankan beberapa command dasar untuk membuat web server pada Eden seperti menginstall Apache2 dan lainnya.  
```
echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
apt-get install wget -y
apt-get install unzip -y
```
Setelah itu, kami membuat domain dengan mengonfigurasi pada `/etc/apache2/sites-available/wise.c03.com.conf`.  
```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.c03.com
        ServerName wise.c03.com
        ServerAlias www.wise.c03.com
        #LogLevel info ssl:warn
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
Domain utama terletak pada ServerName, yaitu `wise.c03.com` serta aliasnya pada ServerAlias, yaitu `www.wise.c03.com`.  
DocumentRoot diletkkan pada `/var/www/wise.c03.com`.  

Konfigurasi tersebut perlu diaktifkan dengan cara
```
a2ensite wise.c03.com.conf
a2dissite 000-default.conf

service apache2 restart
```

Setelah itu, kita perlu mengisi konten file pada `/var/www/wise.c03.com` sesuai dengan resources soal. File tersebut bisa kita dapatkan dengan command `wget` yang sudah diinstall sebelummnya dan diarahkan pada path-nya masing-masing.
```
mkdir /var/www/wise.c03.com
cd /var/www/wise.c03.com

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S0XhL9ViYN7TyCj2W66BNEXQD2AAAw2e" -O /var/www/wise.c03.com/a && rm -rf /tmp/cookies.txt
unzip a
mv /var/www/wise.c03.com/wise/index.php /var/www/wise.c03.com
mv /var/www/wise.c03.com/wise/home.html /var/www/wise.c03.com
mv /var/www/wise.c03.com/wise/anya.jpg /var/www/wise.c03.com

rm -r wise
rm a
```
Konfigurasi pada server selesai, maka domain `wise.c03.com` sudah bisa diakses melalui client.
```
lynx wise.c03.com
```
![8](https://user-images.githubusercontent.com/78243059/198834618-bd99b244-d9dd-410d-a5ef-e5131f8a4e2a.jpg)

  
## Soal 9
**Deskripsi:**
Setelah itu, Loid juga membutuhkan agar url www.wise.yyy.com/index.php/home dapat menjadi menjadi www.wise.yyy.com/home

**Pembahasan:**  
Kami menggunakan alias `Alias "/index.php/home" "/var/www/wise.c03.com/index.php"` dan `Alias "/home" "/var/www/wise.c03.com/index.php"` yang ditammbahkan ke `/etc/apache2/sites-available/wise.c03.com.conf` untuk me-redirect akses file suatu request.  
```
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
</VirtualHost>
```
Maka, saat ada request ke `www.wise.c03.com/index.php/home`, akan dikembalikan file index.php di `/var/www/wise.c03.com/index.php`.
![image](https://user-images.githubusercontent.com/34309557/198837026-db814e74-9e56-46e0-8385-8ebdaf772a17.png)
Laman tersebut akan muncul apabila melakukan `lynx www.wise.c03.com`, `lynx wise.c03.com`, `lynx www.wise.c03.com/home` ataupun `lynx www.wise.c03.com/index.php/home` pada client.

## Soal 10
**Deskripsi:**
Setelah itu, pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com

**Pembahasan:**  
Kami mengonfigurasi subdomain pada `/etc/apache2/sites-available/eden.wise.c03.com.conf` dengan ServerName `eden.wise.c03.com` dan ServerAlias `www.eden.wise.c03.com` serta DocumentRoot ke `/var/www/eden.wise.c03.com`.  
```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.c03.com
        ServerName eden.wise.c03.com
        ServerAlias www.eden.wise.c03.com
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        ErrorDocument 404 /error/404.html
</VirtualHost>
```
Konfigurasi di atas perlu diaktifkan dengan  cara:
```
a2ensite eden.wise.c03.com.conf

service apache2 restart
```
Lalu, kami mengambil resource file dengan command `wget` dan diletkkan ke path-nya masing-masing.
```
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
```
Maka, pada saat ada request lynx ke `www.eden.wise.c03.com`, akan tampil sebagai berikut  
![image](https://user-images.githubusercontent.com/78243059/198835188-de122ffa-4c4d-44cf-a38b-812ddbc3696a.png)


## Soal 11
**Deskripsi:**
Akan tetapi, pada folder /public, Loid ingin hanya dapat melakukan directory listing saja

**Pembahasan:**  
Kami menambahkan konfigurasi mengaktifkan DirectoryListing untuk path `/public` pada 
```
<Directory /var/www/eden.wise.c03.com/public>
        Options +Indexes
</Directory>
```
sehingga keseluruhan filenya menjadi berikut
```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.c03.com
        ServerName eden.wise.c03.com
        ServerAlias www.eden.wise.c03.com
        <Directory /var/www/eden.wise.c03.com/public>
                Options +Indexes
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        ErrorDocument 404 /error/404.html
</VirtualHost>
```
Kami perlu me-restart Apache2 untuk menerapkan konfigurasi tersebut.
```
service apache2 restart
```
Maka, ketika ada request lynx ke `www.eden.wise.c03.com/public`, akan tampil sebagai berikut
![image](https://user-images.githubusercontent.com/78243059/198835377-3e000058-98a7-4b74-9316-697019ee3abc.png)

## Soal 12
**Deskripsi:**
Tidak hanya itu, Loid juga ingin menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache

**Pembahasan:**  
Kami menambahkan kustomisasi error 404 sebagai berikut
```
ErrorDocument 404 /error/404.html
```
sehingga keseluruhan file `/etc/apache2/sites-available/eden.wise.c03.com.conf` menjadi
```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.c03.com
        ServerName eden.wise.c03.com
        ServerAlias www.eden.wise.c03.com
        <Directory /var/www/eden.wise.c03.com/public>
                Options +Indexes
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        ErrorDocument 404 /error/404.html
</VirtualHost>
```
Kami perlu me-restart Apache2 untuk menerapkan konfigurasi tersebut.
```
service apache2 restart
```
Maka, ketika kita akses lynx ke file yang tidak ada, misalnya `www.eden.wise.c03.com/qwe`, akan tampil sebagai berikut
![image](https://user-images.githubusercontent.com/78243059/198835599-dce95ca1-4e58-47c1-a14c-1e4d4dcb5dfc.png)

## Soal 13
**Deskripsi:**
Loid juga meminta Franky untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js

**Pembahasan:**  
Kami menambahkan konfigurasi Alias sebagai berikut
```
Alias "/js" "/var/www/eden.wise.c03.com/public/js"
```
sehingga keseluruhan file `/etc/apache2/sites-available/eden.wise.c03.com.conf` menjadi
```
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.c03.com
        ServerName eden.wise.c03.com
        ServerAlias www.eden.wise.c03.com
        Alias "/js" "/var/www/eden.wise.c03.com/public/js"
        <Directory /var/www/eden.wise.c03.com/public>
                Options +Indexes
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        ErrorDocument 404 /error/404.html
</VirtualHost>
```
Kami perlu me-restart Apache2 untuk menerapkan konfigurasi tersebut.
```
service apache2 restart
```
Maka, ketika kita akses lynx ke `www.eden.wise.c03.com/js` akan diarahkan ke `www.eden.wise.c03.com/public/js`
![image](https://user-images.githubusercontent.com/78243059/198835743-45e48617-ba02-461b-ac25-308fa8098a9f.png)

## Soal 14
**Deskripsi:**
Loid meminta agar www.strix.operation.wise.yyy.com hanya bisa diakses dengan port 15000 dan port 15500

**Pembahasan:**

## Soal 15
**Deskripsi:**
dengan autentikasi username Twilight dan password opStrix dan file di /var/www/strix.operation.wise.yyy

**Pembahasan:**

## Soal 16
**Deskripsi:**
dan setiap kali mengakses IP Eden akan dialihkan secara otomatis ke www.wise.yyy.com

**Pembahasan:**

## Soal 17
**Deskripsi:**
Karena website www.eden.wise.yyy.com semakin banyak pengunjung dan banyak modifikasi sehingga banyak gambar-gambar yang random, maka Loid ingin mengubah request gambar yang memiliki substring “eden” akan diarahkan menuju eden.png.

**Pembahasan:**

## Kendala
- Pada soal 10, walaupun password yang kami temukan sudah benar, tapi flag tidak berhasil kami dapatkan karena decryption kami lakukan di WSL. Akhirnya, kami mencoba descryption di terminal linux dan flag berhasil didapatkan.
