// START: Nomor 4
echo "
zone \"wise.c03.com\" {
    type slave;
    masters { 10.11.2.2; }; // Masukan IP EniesLobby tanpa tanda petik
    file \"/var/lib/bind/wise.c03.com\";
};
" > /etc/bind/named.conf.local
// END: Nomor 4
service bind9 restart