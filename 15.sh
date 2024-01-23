#!/bin/bash

# Define your domain
domain="example.com"

# Define the directory where your zone files are located
zone_directory="/etc/bind"

# Define the key directory
key_directory="/etc/bind/keys"

# Change to the key directory
cd $key_directory

# Generate new keys every month
if [ $(date +%m -d tomorrow) != $(date +%m) ]; then
    # Generate the Key Signing Key (KSK)
    dnssec-keygen -a RSASHA256 -b 2048 -n ZONE -f KSK $domain

    # Generate the Zone Signing Key (ZSK)
    dnssec-keygen -a RSASHA256 -b 1024 -n ZONE $domain
fi

# Change to the zone directory
cd $zone_directory

# Include the keys in your zone file
echo "\$INCLUDE $key_directory/K$domain*.key" >> db.$domain

# Sign the zone
dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o $domain -t db.$domain

# Reload BIND
rndc reload

# Verify the DNSSEC deployment
dig +dnssec www.$domain