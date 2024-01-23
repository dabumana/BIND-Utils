#!/bin/bash

# Flush all current rules from iptables
iptables -F

# Allow connections from your internal network
iptables -A INPUT -s 192.168.0.0/16 -j ACCEPT

# Allow connections from localhost
iptables -A INPUT -s 127.0.0.1 -j ACCEPT

# Allow incoming connections on ports that your DNS server needs
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT

# Deny all other incoming connections
iptables -P INPUT DROP

# Allow all outgoing connections
iptables -P OUTPUT ACCEPT

# Save rules
/sbin/service iptables save