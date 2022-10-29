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

## Soal 2
**Deskripsi:**
Untuk mempermudah mendapatkan informasi mengenai misi dari Handler, bantulah Loid membuat website utama dengan akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise

**Pembahasan:**

## Soal 3
**Deskripsi:**
Setelah itu ia juga ingin membuat subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com yang diatur DNS-nya di WISE dan mengarah ke Eden 

**Pembahasan:**

## Soal 4
**Deskripsi:**
Buat juga reverse domain untuk domain utama

**Pembahasan:**


## Soal 5
**Deskripsi:**
Agar dapat tetap dihubungi jika server WISE bermasalah, buatlah juga Berlint sebagai DNS Slave untuk domain utama 

**Pembahasan:**

## Soal 6
**Deskripsi:**
Karena banyak informasi dari Handler, buatlah subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com yang didelegasikan dari WISE ke Berlint dengan IP menuju ke Eden dalam folder operation

**Pembahasan:**

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
