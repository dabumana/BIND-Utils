#!/bin/bash

# Path to your zone file
ZONEFILE="/etc/bind/db.yourdomain.com"

# Function to add a DNS record
add_dns_record() {
    echo "$1 IN A $2" >> $ZONEFILE
    rndc reload
}

# Function to delete a DNS record
delete_dns_record() {
    sed -i "/^$1/d" $ZONEFILE
    rndc reload
}

# Function to list all DNS records
list_dns_records() {
    cat $ZONEFILE
}

# Check command line arguments and call the appropriate function
if [ "$1" = "add" ]; then
    add_dns_record $2 $3
elif [ "$1" = "delete" ]; then
    delete_dns_record $2
elif [ "$1" = "list" ]; then
    list_dns_records
else
    echo "Usage: $0 {add|delete|list} {hostname} {ip-address}"
fi