echo "
zone \"wise.c03.com\" {
    type master;
    allow-transfer { 10.11.3.2; };
    file \"/etc/bind/wise/wise.c03.com\";
};

zone \"2.11.10.in-addr.arpa\" {
    type master;
    file \"/etc/bind/wise/2.11.10.in-addr.arpa\";
};

" > /etc/bind/named.conf.local

mkdir /etc/bind/wise

echo ";
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
@               IN      NS      wise.c03.com.
@               IN      A       10.11.2.2       ; IP EniesLobby
www             IN      CNAME   wise.c03.com.
eden                            IN      A       10.11.3.3
; www.eden.wise.c03.com.          IN      CNAME   eden.wise.c03.com.
ns1       IN    A       10.11.3.2
operation       IN    NS      ns1
@         IN    AAAA    ::1
" > /etc/bind/wise/wise.c03.com

service bind9 restart

cp /etc/bind/db.local /etc/bind/wise/2.11.10.in-addr.arpa

echo ";
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
2                       IN      PTR     wise.c03.com.   ; Byte ke-4 EniesLobby
" > /etc/bind/wise/2.11.10.in-addr.arpa

service bind9 restart

echo "
options {
        directory \"/var/cache/bind\";
        forwarders {
                192.168.122.1; // IP Foosha
        };
        allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

service bind9 restart