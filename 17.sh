#!/bin/bash

# Define the zone
zone="yourdomain.com"

# Change to the appropriate directory
cd /etc/bind

# Enable DNSSEC validation
echo "dnssec-validation auto;" >> /etc/bind/named.conf.options

# Define the trusted keys for the zone
echo "trusted-keys {" >> /etc/bind/named.conf.options
echo "    \"$zone\" {" >> /etc/bind/named.conf.options
echo "        // Paste the public KSK for the zone here" >> /etc/bind/named.conf.options
echo "    };" >> /etc/bind/named.conf.options
echo "};" >> /etc/bind/named.conf.options

# Restart BIND
service bind9 restart