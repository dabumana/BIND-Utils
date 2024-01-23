#!/bin/bash

# Define your domain and the alias
DOMAIN="example.com."
ALIAS="www.example.com."

# Backup the original BIND zone file
sudo cp /var/named/db.$DOMAIN /var/named/db.$DOMAIN.backup

# Add the CNAME record to the BIND zone file
echo "$ALIAS IN CNAME $DOMAIN" | sudo tee -a /var/named/db.$DOMAIN

# Increment the serial number in the zone file
sudo sed -i '/Serial/ s/[0-9]\+/&+1/' /var/named/db.$DOMAIN

# Check the BIND configuration for errors
sudo named-checkconf

# Check the BIND zone file for errors
sudo named-checkzone $DOMAIN /var/named/db.$DOMAIN

# If no errors, restart the BIND service to apply changes
sudo systemctl restart named