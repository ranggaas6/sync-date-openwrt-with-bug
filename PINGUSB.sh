#!/bin/sh
# This should ping the cable modem and if it's not reachable, bounce the wan interface

dtdir="/root/date"
initd="/etc/init.d"
logp="/root/logp"
jamup2="/root/jam2_up.sh"
jamup="/root/jamup.sh"
nmfl="$(basename "$0")"
scver="3.5"

for i in https://google.com
do

function usbmodem() {
    httping -l -g $i -c 3 >/dev/null
    if [ $? -eq 0 ]
      then 
        echo "The network is up"
        exit 0
      else
        echo "The network is down"
    fi
}

	# Runner
	if [[ "$2" == "cron" ]]; then
		usbmodem
	else
		usbmodem
	fi
	done
