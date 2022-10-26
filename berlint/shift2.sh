// START: Nomor 4
echo "
zone \"wise.c03.com\" {
    type slave;
    masters { 10.11.2.2; };
    file \"/var/lib/bind/wise.c03.com\";
};

zone \"operation.wise.c03.com\" {
    type master;
    file \"/etc/bind/c03/operation.wise.c03.com\";
};
" > /etc/bind/named.conf.local
// END: Nomor 4

// START: Nomor 5
echo "
options {
    directory \"/var/cache/bind\";
    allow-query{any;};

    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

mkdir /etc/bind/c03

echo ";
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
www.strix.operation.wise.c03.com.         IN      CNAME   strix.operation.wise.c03.com.
; -- END: Nomor 7 --
" > /etc/bind/c03/operation.wise.c03.com
// END: Nomor 5

service bind9 restart