#!/bin/bash

for j in {104.16.51.111} ; do
    for i in {192.168.8.1} ; do
        if ping -I eth1 -q -c 1 -w 1 $i >/dev/null 2>/dev/null ; then
            echo "$i is up"
            break
        else
            echo "$i is down"
            if ping -c1 $j >/dev/null 2>/dev/null ; then
                echo "$j is up"
                break
            else
                echo "$j is down"
            fi
        fi
    done
done
