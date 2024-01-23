#!/bin/bash

# Define your domain
domain="yourdomain.com"

# Define DNS data directory
dnsDataDir="/etc/bind"

# Define named.conf.options file path
optionsFile="${dnsDataDir}/named.conf.options"

# Define named.conf.local file path
localFile="${dnsDataDir}/named.conf.local"

# Configure the options file for the recursive server
echo 'options {
    directory "/var/cache/bind";
    recursion yes;  # enables recursive queries
    allow-recursion { any; };  # allows recursive queries from "any" hosts
};' > $optionsFile

# Configure the local file for the authoritative server
echo 'zone "'$domain'" {
    type master;
    file "/etc/bind/db.'$domain'";
};' > $localFile

# Create a basic DB file for the domain
echo '$TTL    604800
@       IN      SOA     ns.'$domain'. root.localhost. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
; name servers - NS records
    IN      NS      ns.'$domain'.

; name servers - CNAME records
ns.'$domain'.          IN      CNAME   www.'$domain'.

; 192.0.2.0/24 - CNAME records
www.'$domain'.         IN      CNAME   ns.'$domain'.' > "${dnsDataDir}/db.${domain}"

# Restart BIND9 service
service bind9 restart