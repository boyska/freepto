#!/bin/bash

echo "TOR Transparent Proxy"
echo "Inserisci la tua password ed automagicamente tutto il traffico sarà rediretto verso TOR"

# Detect current user
user=`id -un`

# Change DNS server
sudo cp /etc/resolv.conf /root/rsocks/backup/resolv.conf.backup
echo "nameserver 127.0.0.1" | sudo tee -a /etc/resolv.conf

# Iptables backup
sudo iptables-save > /root/rsocks/backup/iptables.backup

# Add TransparentProxy rules on Tor config
echo "VirtualAddrNetwork 10.192.0.0/10" | sudo tee -a /etc/tor/torrc
echo "AutomapHostsOnResolve 1" | sudo tee -a /etc/tor/torrc
echo "TransPort 9040" | sudo tee -a /etc/tor/torrc
echo "DNSPort 53" | sudo tee -a /etc/tor/torrc

# Restart TOR
sudo /etc/init.d/tor restart

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
