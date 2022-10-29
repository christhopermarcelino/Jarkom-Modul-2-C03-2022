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
@                               IN      A       10.11.2.2
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
; -- START: Nomor 6 --
@                               IN      NS      operation.wise.c03.com.
@                               IN      A       10.11.3.3
www                             IN      CNAME   operation.wise.c03.com.
; -- END: Nomor 6 --
;
; -- START: Nomor 7 --
strix                                     IN      A       10.11.3.3
www.strix.operation.wis
```

## Soal 7
**Deskripsi:**
Untuk informasi yang lebih spesifik mengenai Operation Strix, buatlah subdomain melalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com yang mengarah ke Eden

**Pembahasan:**


## Soal 8
**Deskripsi:**
Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver www.wise.yyy.com. Pertama, Loid membutuhkan webserver dengan DocumentRoot pada /var/www/wise.yyy.com

**Pembahasan:**


## Soal 9
**Deskripsi:**
Setelah itu, Loid juga membutuhkan agar url www.wise.yyy.com/index.php/home dapat menjadi menjadi www.wise.yyy.com/home

**Pembahasan:**

## Soal 10
**Deskripsi:**
Setelah itu, pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com

**Pembahasan:**

## Soal 11
**Deskripsi:**
Akan tetapi, pada folder /public, Loid ingin hanya dapat melakukan directory listing saja

**Pembahasan:**

## Soal 12
**Deskripsi:**
Tidak hanya itu, Loid juga ingin menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache

**Pembahasan:**

## Soal 13
**Deskripsi:**
Loid juga meminta Franky untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js

**Pembahasan:**

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
