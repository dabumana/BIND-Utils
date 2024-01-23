#!/bin/bash

# Define the IP address of your internal DNS server
INTERNAL_DNS="192.168.1.1"

# Backup the original resolv.conf file
sudo cp /etc/resolv.conf /etc/resolv.conf.backup

# Clear the resolv.conf file
echo "" | sudo tee /etc/resolv.conf

# Set the internal DNS server
echo "nameserver $INTERNAL_DNS" | sudo tee -a /etc/resolv.conf