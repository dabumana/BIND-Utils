#!/bin/bash

# Define your domain
domain="example.com"

# Change to the directory where your zone files are located
cd /etc/bind

# Generate the Key Signing Key (KSK)
dnssec-keygen -a RSASHA256 -b 2048 -n ZONE -f KSK $domain

# Generate the Zone Signing Key (ZSK)
dnssec-keygen -a RSASHA256 -b 1024 -n ZONE $domain

# Include the keys in your zone file
echo "\$INCLUDE K$domain*.key" >> db.$domain

# Sign the zone
dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o $domain -t db.$domain

# Reload BIND
rndc reload

# Verify the DNSSEC deployment
dig +dnssec www.$domain