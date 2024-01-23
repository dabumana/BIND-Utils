#!/bin/bash

# Edit the BIND configuration file
# sudo vi /etc/named.conf

# Find and set the following directives:
# dnssec-enable yes;
# dnssec-validation yes;
# dnssec-lookaside auto;

# Save and exit the file

# Restart the BIND service to apply the changes
sudo systemctl restart named

# Test DNSSEC validation
dig . DNSKEY | grep -Ev '^ ($|;)' > root.keys
dig +sigchase +trusted-key=./root.keys . SOA | grep -i validation