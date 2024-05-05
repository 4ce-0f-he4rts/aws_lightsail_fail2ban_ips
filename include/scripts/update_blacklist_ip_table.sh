#!/bin/bash

FAIL2BAN_LOG="/var/log/fail2ban.log"
BLACKLIST_FILE="/home/ubuntu/blacklist_ip_table/blacklist_ip_table.txt"

# Check if Fail2Ban log file exists
if [ ! -f "$FAIL2BAN_LOG" ]; then
    echo "Fail2Ban log file not found: $FAIL2BAN_LOG"
    exit 1
fi

# Create blacklisted IP table file if it doesn't exist
touch "$BLACKLIST_FILE"

# Parse Fail2Ban log file for banned IP addresses and append to blacklisted IP table file
banned_ips=$(grep "Ban " "$FAIL2BAN_LOG" | awk '{print $NF}' | sort -u)

while IFS= read -r ip; do
    # Check if IP already exists in blacklisted IP table file
    if ! grep -qF "$ip" "$BLACKLIST_FILE"; then
        echo "$ip" >> "$BLACKLIST_FILE"
    fi
done <<< "$banned_ips"
