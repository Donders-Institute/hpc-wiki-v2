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

vnchost=$(echo $vncserver | awk -F ':' '{print $1}')
vncport=$(echo $vncserver | awk -F ':' '{print $2}')

[ $vncport -lt 99 ] && vncport=$((5900 + $vncport))

ftpport=$(($vncport + 1000))

socket=${vncport}

read -p  "DCCN username: " username

# create SSH tunnel in background with a control socket
ssh -M -S ${socket} -fNT -L $vncport:$vnchost:$vncport -L ${ftpport}:$vnchost:22 $username@ssh.dccn.nl

export socket
export username
trap stop SIGTERM SIGINT

cat << EOF
tunnel ${socket} created.

!! Keep this terminal open !!

- for VNC, connect VNC client to localhost:${vncport}
- for data transfer, connect SFTP client to localhost:{ftpport}
- use Ctrl-C to close the tunnel.

EOF

while true; do
    sleep 1
done
