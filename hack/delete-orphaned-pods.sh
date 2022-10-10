#!/bin/bash
num=$(tail /var/log/syslog | grep "any similar errors. Turn up verbosity to see them." |tail -1 | awk '{print $23}' |sed 's/\\"//g')
echo $num

while [ $num ]
do
    [ -d "/var/lib/kubelet/pods/${num}" ] && rm -rf /var/lib/kubelet/pods/${num}
    
    sleep 2s
    num=$(tail /var/log/syslog | grep "any similar errors. Turn up verbosity to see them." |tail -1 | awk '{print $23}' |sed 's/\\"//g')
    [ -d "/var/lib/kubelet/pods/${num}" ] || num=
    
    echo "$num remaining"
    
done
