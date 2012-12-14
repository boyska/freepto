#!/bin/bash

echo "TOR Transparent Proxy"
echo "Inserisci la tua password ed automagicamente,"
echo "tutto il traffico sarà rediretto verso TOR."

# Detect current user
user=`id -un`

[ -d /home/$user/.tp-tor ] || mkdir /home/$user/.tp-tor

# Change DNS server
sudo cp /etc/resolv.conf /home/$user/.tp-tor/resolv.conf.backup
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf

# Iptables backup
sudo iptables-save > /home/$user/.tp-tor/iptables.backup

# Delete all Iptables rules
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X

# Redirec all DNS traffic trought TOR
sudo iptables -t nat -A OUTPUT -p udp -m owner --uid-owner $user -m udp --dport 53 -j REDIRECT --to-ports 53
sudo iptables -t filter -A OUTPUT -p udp -m owner --uid-owner $user -m udp --dport 53 -j ACCEPT

# Rediret all traffic throught TOR
sudo iptables -t nat -A OUTPUT -p tcp -m owner --uid-owner $user -m tcp -j REDIRECT --to-ports 9040
sudo iptables -t filter -A OUTPUT -p tcp -m owner --uid-owner $user -m tcp --dport 9040 -j ACCEPT
sudo iptables -t filter -A OUTPUT -m owner --uid-owner $user -j DROP
