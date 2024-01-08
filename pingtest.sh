#!/bin/sh
# This should ping the cable modem and if it's not reachable, bounce the wan interface

dtdir="/root/date"
initd="/etc/init.d"
logp="/root/logp"
jamup2="/root/jam2_up.sh"
jamup="/root/jamup.sh"
nmfl="$(basename "$0")"
scver="3.5"

for i in 104.16.51.111 104.16.53.111 104.16.143.190 104.17.224.203 162.159.128.7 162.159.138.6 172.67.75.37 104.26.14.208 104.26.15.208
do

function ngewan() {
    ping -c 1 -w 1 $i > /dev/null
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
    fi
}

function nyetart() {
	startvpn="${nmfl}: Restarting"
	echo -e "${startvpn} VPN tunnels if available."
	logger "${startvpn} VPN tunnels if available."
	if [[ -f "$initd"/openclash ]] && [[ $(uci -q get openclash.config.enable) == "1" ]]; then "$initd"/openclash restart && echo -e "${startvpn} OpenClash"; fi
}

function ngeclash() {
    if  [ "$(ping -c 1 -W 1 $i | grep '100% packet loss' )" != "" ]; then
	    echo "Openclash "eth1" has got no internet connection"
            logger -t Openclash "eth1" has got no internet connection
       	    nyetart
    else
            echo "Openclash  "eth1" is working with internet connection"
            logger -t Openclash "eth1" is working with internet connection
    fi
}

	# Runner
	if [[ "$2" == "cron" ]]; then
		ngewan
  		ngeclash
	else
		ngewan
		ngeclash
	fi
	done
