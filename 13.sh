#!/bin/bash

# Define the zone
zone="yourdomain.com"

# Define the ACL
acl "trusted" {
    192.0.2.0/24;    # Network 1
    203.0.113.0/24;  # Network 2
    localhost;
};

# Change to the appropriate directory
cd /etc/bind

# Add the ACL to the options file
echo "acl \"trusted\" {" >> /etc/bind/named.conf.options
echo "    192.0.2.0/24;    # Network 1" >> /etc/bind/named.conf.options
echo "    203.0.113.0/24;  # Network 2" >> /etc/bind/named.conf.options
echo "    localhost;" >> /etc/bind/named.conf.options
echo "};" >> /etc/bind/named.conf.options

# Restrict queries to the trusted ACL
echo "allow-query { trusted; };" >> /etc/bind/named.conf.options

# Restart BIND
service bind9 restart