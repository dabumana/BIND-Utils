#!/bin/bash

# Define the path to the named.conf file
named_conf="/etc/named.conf"

# Define the logging clause
logging_clause="
logging {
    channel simple_log {
        file "/var/log/named/bind.log" versions 3 size 5m;
        severity dynamic;
        print-time yes;
        print-severity yes;
        print-category yes;
    };
    category default {
        simple_log;
    };
};"

# Backup the original named.conf file
cp $named_conf $named_conf.bak

# Append the logging clause to the named.conf file
echo "$logging_clause" >> $named_conf

# Restart the BIND service to apply changes
service named restart