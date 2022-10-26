echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y

echo nameserver 10.11.2.2 > /etc/resolv.conf
echo nameserver 10.11.3.2 >> /etc/resolv.conf
