#!/bin/bash

# Define the path to the named.conf file
named_conf="/etc/named.conf"

# Define the path to the file containing the list of blocked domains
blocked_domains="/etc/named/blockeddomains.conf"

# Keep the following format for blockeddomains.conf:
# maliciousdomain1.com CNAME .
# maliciousdomain2.com CNAME .

# Define the options clause
options_clause="
options {
    directory \"/var/named\";
    response-policy { zone \"rpz\"; };
};"

# Define the rpz zone clause
rpz_zone_clause="
zone \"rpz\" {
    type master;
    file \"$blocked_domains\";
};"

# Backup the original named.conf file
cp $named_conf $named_conf.bak

# Append the options and rpz zone clauses to the named.conf file
echo "$options_clause" >> $named_conf
echo "$rpz_zone_clause" >> $named_conf

# Restart the BIND service to apply changes
service named restart