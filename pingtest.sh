#!/bin/sh
# This should ping the cable modem and if it's not reachable, bounce the wan interface

ping -c 1 -w 1 192.168.8.1 > /dev/null
if [ $? -ne 0 ]; then
	echo "Ping didn't exit cleanly"
	ifdown wan
	echo "ifdown fired"
	sleep 10	# I have no idea if this is needed. 
	ifup wan
	echo "ifup fired"
	sleep 10	# again, give it a moment to come back up and settle
else
	echo "ping was OK"

sleep 10		# just to give me time to kill it in case it goes haywire, could shorten to 1. 
    
    # Check vpn-tunnel "eth1" and ping cz.nic if internet connection work
    if  [ "$(ping -c 1 -W 1 googgle.co.id | grep '100% packet loss' )" != "" ]; then
            echo "Openclash "eth1" has got no internet connection -> restart it"
            logger -t Openclash "eth1" has got no internet connection -> restart it
            /etc/init.d/openclash restart
    else
            echo "Openclash  "eth1" is working with internet connection"
            logger -t Openclash "eth1" is working with internet connection
    fi
fi