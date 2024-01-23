#!/bin/bash

# Define the path to the BIND log file
BIND_LOG="/var/log/named/debug.log"

# Add the logging configuration to the BIND configuration
echo "
logging {
    channel debug_log {
        file \"$BIND_LOG\" versions 3 size 5m;
        severity dynamic;
        print-time yes;
    };
    category default { debug_log; };
};" | sudo tee -a /etc/named.conf

# Restart the BIND service to apply changes
sudo systemctl restart named