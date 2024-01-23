#!/bin/bash

# Define your domain
domain="yourdomain.com"

# Path to named.conf
named_conf="/etc/bind/named.conf.local"

# Check if domain is already in named.conf
if grep -q "\$domain" "\$named_conf"; then
    echo "Domain \$domain is already configured."
else
    # If not, add it
    echo "
zone \"\$domain\" {
    type master;
    file \"/etc/bind/db.\$domain\";
};
" >> "\$named_conf"

    echo "Domain \$domain has been configured."
fi