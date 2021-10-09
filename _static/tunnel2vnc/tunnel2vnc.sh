#!/bin/bash

function stop() {
    echo 
    echo -n "closing tunnel ${socket} ..."
    ssh -S ${socket} -O exit $username@ssh.dccn.nl
    exit 0
}

unset vncserver
unset username

read -p  "VNC server: " vncserver
read -p  "DCCN username: " username

vnchost=$(echo $vncserver | awk -F ':' '{print $1}')
vncport=$(echo $vncserver | awk -F ':' '{print $2}')

[ $vncport -lt 99 ] && vncport=$((5900 + $vncport))

socket=${vncport}

# create SSH tunnel in background with a control socket
ssh -M -S ${socket} -fNT -L $vncport:$vnchost:$vncport $username@ssh.dccn.nl

export socket
export username
trap stop SIGTERM SIGINT

cat << EOF
tunnel ${socket} created.

Keep this terminal open and use VNC client to connect localhost:${vncport}, or
use Ctrl-C to close the tunnel.
EOF

while true; do
    sleep 1
done
