echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
apt-get install wget -y
apt-get install unzip -y
