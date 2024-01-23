#!/bin/bash

# Define the path to the named.conf file
named_conf="/etc/named.conf"

# Define the options clause
options_clause="
options {
    directory \"/var/named\";
    dump-file \"/var/named/data/cache_dump.db\";
    statistics-file \"/var/named/data/named_stats.txt\";
    memstatistics-file \"/var/named/data/named_mem_stats.txt\";
    allow-query { any; };
    recursion yes;
    allow-recursion { any; };
    listen-on port 53 { any; };
    allow-transfer { none; };  # This line disables zone transfers
    version \"not currently available\";  # This line hides BIND version
};"

# Backup the original named.conf file
cp $named_conf $named_conf.bak

# Append the options clause to the named.conf file
echo "$options_clause" >> $named_conf

# Restart the BIND service to apply changes
service named restart