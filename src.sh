#!/usr/bin/env bash

echo 'deb http://deb.torproject.org/torproject.org quantal main' > /etc/apt/sources.list.d/tor.list
gpg --keyserver keys.gnupg.net --recv 886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
sudo apt-get update

apt-get install vim curl wget less most macchanger dmsetup thunderbird seahorse thunderbird enigmail gufw redsocks tor tor-arm

#TODO: copia settaggi in home (xchat, firefox, thunderbird)
#TODO: installa certificati a/i
