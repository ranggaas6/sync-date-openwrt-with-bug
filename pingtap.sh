#!/bin/bash

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
		ngeping
	else
		ngeping
	fi
