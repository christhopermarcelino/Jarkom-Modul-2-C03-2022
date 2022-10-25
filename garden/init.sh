echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt-get install dnsutils -y

# 

apt-get install lynx

echo '10.11.3.3	wise.yyy.com' >> /etc/hosts
echo '10.11.3.3	www.wise.yyy.com' >> /etc/hosts
echo '10.11.3.3	eden.wise.yyy.com' >> /etc/hosts
echo '10.11.3.3	www.eden.wise.yyy.com' >> /etc/hosts
