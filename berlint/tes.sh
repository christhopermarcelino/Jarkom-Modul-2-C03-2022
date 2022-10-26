echo "
zone \"wise.c03.com\" {
    type slave;
    masters { 10.11.2.2; }; // Masukan IP EniesLobby tanpa tanda petik
    file \"/var/lib/bind/wise.c03.com\";
};

zone \"operation.wise.c03.com\" {
    type master;
    file \"/etc/bind/delegasi/operation.wise.c03.com\";
};

" > /etc/bind/named.conf.local
    
service bind9 restart

echo " 
options {
        directory \"/var/cache/bind\";
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service W bind9 restart

mkdir /etc/bind/delegasi

echo ";
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     operation.wise.c03.com. root.operation.wise.c03.com. (
                     2022100601         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      operation.wise.c03.com.
@       IN      A       10.11.3.2   
" > /etc/bind/delegasi/operation.wise.c03.com

service bind9 restart
