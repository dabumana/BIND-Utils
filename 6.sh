#!/bin/bash

# Define the IP address of your Anycast network
ANYCAST_IP="10.0.0.1"

# Define the network interface you want to apply the Anycast IP to
INTERFACE="eth0"

# Define the path to your BIND configuration file
BIND_CONF="/etc/bind/named.conf.options"

# Backup the original BIND configuration file
sudo cp $BIND_CONF $BIND_CONF.backup

# Clear the BIND configuration file
echo "" | sudo tee $BIND_CONF

# Set the BIND configuration for Anycast
echo "options {
    listen-on { $ANYCAST_IP; };
    listen-on-v6 { none; };
};" | sudo tee -a $BIND_CONF

# Restart BIND
sudo systemctl restart bind9

# Install keepalived
sudo apt-get install keepalived

# Define the path to your keepalived configuration file
KEEPALIVED_CONF="/etc/keepalived/keepalived.conf"

# Backup the original keepalived configuration file
sudo cp $KEEPALIVED_CONF $KEEPALIVED_CONF.backup

# Clear the keepalived configuration file
echo "" | sudo tee $KEEPALIVED_CONF

# Set the keepalived configuration for Anycast and Load Balancing
echo "vrrp_instance VI_1 {
    state MASTER
    interface $INTERFACE
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 1111
    }
    virtual_ipaddress {
        $ANYCAST_IP
    }
}" | sudo tee -a $KEEPALIVED_CONF

# Restart keepalived
sudo systemctl restart keepalived