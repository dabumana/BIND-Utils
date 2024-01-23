#!/bin/bash

# Define the loopback address and the address of the other domain controller
LOOPBACK_ADDRESS="127.0.0.1"
SECONDARY_DNS="192.168.1.2" # Replace with the IP address of your secondary domain controller

# Define the path to your named.conf file
NAMED_CONF="/etc/bind/named.conf.options"

# Backup the original named.conf file
cp $NAMED_CONF $NAMED_CONF.bak

# Define the new DNS settings
DNS_SETTINGS="
options {
    directory \"/var/cache/bind\";
    recursion yes;
    allow-recursion { any; };
    listen-on { $LOOPBACK_ADDRESS; $SECONDARY_DNS; };
    allow-transfer { none; };

    dnssec-validation auto;
    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};