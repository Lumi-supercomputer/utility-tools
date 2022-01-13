#!/bin/bash
set -m
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

# loop device and mount namespace info
#lsns
#/sbin/losetup --list


function cleanup {
    if [[ -n $mnsp ]];then
    export procs=$(ps -fu $USER | tail -n +2)
    while IFS= read -r proc_l; do
        export proc=($proc_l)
        export ppid=${proc[2]}
        export pid=${proc[1]}
        if [[ $ppid -eq  1 ]];then
            if [[ -n "$(lsns -p $pid | grep "$mnsp" )" ]];then
               kill -9 $pid 
            fi
        fi
    done <<< "$procs"
    fi
    # Only one should be able to exist?
    # Safe to kill based on name?
    dbus_pid=$(echo "$procs" | grep -- "dbus-daemon" | cut -d " " -f2 )
    kill $dbus_pid &>/dev/null
    kill -9 $session_pid &>/dev/null
}


eval $(dbus-launch --sh-syntax )
xfce4-session  &  
session_pid=$!
mnsp=$(lsns -p $! | grep mnt | cut -d " " -f1 )
trap cleanup EXIT INT
wait $session_pid




