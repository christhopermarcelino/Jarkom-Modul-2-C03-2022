// Forward WISE ke Ostania supaya bisa terhubung ke internet
echo "
options {
    directory \"/var/cache/bind\";
    forwarders {
        192.168.122.1;
    };
    allow-query{any;};

    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};" > /etc/bind/named.conf.options

// Menyiapkan zone
echo "
zone \"wise.c03.com\" {
    type master;
    notify yes;
    also-notify { 10.11.3.2; };
    allow-transfer { 10.11.3.2; };
    file \"/etc/bind/wise/wise.c03.com\";
};

zone \"2.11.10.in-addr.arpa\" {
    type master;
    file \"/etc/bind/wise/2.11.10.in-addr.arpa\";
};
" > /etc/bind/named.conf.local

mkdir /etc/bind/wise

// Setting DNS untuk wise.c03.com
echo ";
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
; -- START: Nomor 1 --
@                               IN      NS      wise.c03.com.
@                               IN      A       10.11.2.2
www                             IN      CNAME   wise.c03.com.
; -- END: Nomor 1 --
;
; -- START: Nomor 2 --
eden                            IN      A       10.11.3.3
www.eden.wise.c03.com.          IN      CNAME   eden.wise.c03.com.
; -- END: Nomor 2 --
;
@       IN      AAAA    ::1
" > /etc/bind/wise/wise.c03.com

// Membuat reverse domain
// START: Nomor 3
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
2                       IN      PTR     wise.c03.com.   ; Byte ke-4
" > /etc/bind/wise/2.11.10.in-addr.arpa
// END: Nomor 3

service bind9 restart