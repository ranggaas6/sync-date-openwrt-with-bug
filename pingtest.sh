#!/bin/sh
# This should ping the cable modem and if it's not reachable, bounce the wan interface
for i in 104.16.51.111 104.16.53.111 104.16.143.190
do

function ngewan() {
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
    fi
}

function nyetart() {
	startvpn="${nmfl}: Restarting"
	echo -e "${startvpn} VPN tunnels if available."
	logger "${startvpn} VPN tunnels if available."
	if [[ -f "$initd"/openclash ]] && [[ $(uci -q get openclash.config.enable) == "1" ]]; then "$initd"/openclash restart && echo -e "${startvpn} OpenClash"; fi
}

function ngeclash() {
    if  [ "$(ping -c 3 -W 1 $i | grep '100% packet loss' )" != "" ]; then
	    echo "Openclash "eth1" has got no internet connection -> restart it"
            logger -t Openclash "eth1" has got no internet connection -> restart it
            /etc/init.d/openclash restart
    else
            echo "Openclash  "eth1" is working with internet connection"
            logger -t Openclash "eth1" is working with internet connection
    fi
}

	# Runner
	if [[ "$2" == "cron" ]]; then
		ngewan
		ngewan
  		ngeclash
	else
		ngewan
		ngewan
		ngeclash
	fi
	done
