#!/bin/bash

dtdir="/root/date"
initd="/etc/init.d"
logp="/root/logp"
jamup2="/root/jam2_up.sh"
jamup="/root/jamup.sh"
nmfl="$(basename "$0")"
scver="3.5"

function ngewan() {
    ping -c 1 -w 1 192.168.8.1 > /dev/null
    if [ $? -ne 0 ]; then
    echo "MODEM TIDAK BISA MENDAPATKAN PING"
	ifdown wan
	echo "MEMATIKAN MODEM"
	sleep 10	# I have no idea if this is needed. 
	ifup wan
	echo "MENGHIDUPKAN MODEM"
	sleep 10	# again, give it a moment to come back up and settle
    else
	echo "MODEM BERHASIL MELAKUKAN PING"
    fi
}

function nyetart() {
	startvpn="${nmfl}: Restarting"
	echo -e "${startvpn} VPN tunnels if available."
	logger "${startvpn} VPN tunnels if available."
	if [[ -f "$initd"/openclash ]] && [[ $(uci -q get openclash.config.enable) == "1" ]]; then "$initd"/openclash restart && echo -e "${startvpn} OpenClash"; fi
}

function ngeping() {
for k in 104.21.8.110 ; do
for j in 104.21.8.129 ; do
for i in 172.67.139.118 ; do
for h in 172.67.139.117 ; do
for g in 104.21.8.126 ; do
for f in 172.67.139.115 ; do
for e in 172.67.139.114 ; do
for d in 104.21.8.123 ; do
for c in 172.67.139.112 ; do
for b in 172.67.139.111 ; do
for a in 172.67.139.011 ; do
        
        if  ping -q -c 5 -W 1 $a ; then
             echo "$a is up"
        else
             echo "$a is down"
        if  ping -q -c 5 -W 1 $b ; then
             echo "$b is up"
        else
             echo "$b is down"
        if  ping -q -c 5 -W 1 $c ; then
             echo "$c is up"
        else
             echo "$c is down"
        if ping -q -c 5 -W 1 $d ; then
             echo "$d is up"
        else
             echo "$d is down"
        if  ping -q -c 5 -W 1 $e ; then
             echo "$e is up"
        else
             echo "$e is down"
        if  ping -q -c 5 -W 1 $f ; then
             echo "$f is up"
        else
             echo "$f is down"
        if ping -q -c 5 -W 1 $g ; then
             echo "$g is up"
        else
             echo "$g is down"
        if  ping -q -c 5 -W 1 $h ; then
             echo "$h is up"
        else
             echo "$h is down"
        if  ping -q -c 5 -W 1 $i ; then
             echo "$i is up"
        else
             echo "$i is down"
        if ping -q -c 5 -W 1 $j ; then
             echo "$j is up"
        else
             echo "$j is down"
        if ping -q -c 5 -W 1 $k ; then
             echo "$k is up"
        else
             echo "$k is down"
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
done
done
done
done
done
done
done
done
done
done
done
}

	# Runner
	if [[ "$2" == "cron" ]]; then
		ngewan
		ngeping
	else
	    	ngewan
		ngeping
	fi
