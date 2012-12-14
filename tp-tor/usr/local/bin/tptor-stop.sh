#!/bin/bash

# Detect current user
user=`id -un`

# Change DNS server
sudo rm /etc/resolv.conf
sudo mv /home/$user/.tp-tor/resolv.conf.backup /etc/resolv.conf

# Delete all Iptables rules
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X

# Restore Iptables backup
sudo iptables-restore < /home/$user/.tp-tor/iptables.backup
