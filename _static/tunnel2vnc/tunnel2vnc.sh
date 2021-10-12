#!/bin/bash

function stop() {
    echo 
    ssh -S ${socket} -O exit ${username}@ssh.dccn.nl
    exit 0
}

unset vncserver
unset username

read -p  "VNC server: " vncserver

vnchost=$(echo $vncserver | awk -F ':' '{print $1}')
vncport=$(echo $vncserver | awk -F ':' '{print $2}')

[ $vncport -lt 100 ] && vncport=$((5900 + $vncport))

# vncport at this point should be between 5901 and 5999
[[ $vncport -lt 5901 || $vncport -gt 5999 ]] && echo "invalid VNC server" >&2 && exit 1

ftpport=$(($vncport + 1000))

socket=${vncport}

read -p  "DCCN username: " username

# create SSH tunnel in background with a control socket
ssh -M -S ${socket} -fNT -o ExitOnForwardFailure=yes -L $vncport:$vnchost:$vncport -L ${ftpport}:$vnchost:22 ${username}@ssh.dccn.nl

if [ $? -ne 0 ]; then
    echo "fail to setup tunnel" >&2
    exit 1
fi

export socket
export username
trap stop SIGTERM SIGINT

cat << EOF

!! Keep this terminal open !!

- for VNC, connect VNC client to localhost:${vncport}
- for data transfer, connect SFTP client to localhost:{ftpport}
- use Ctrl-C to close the tunnel.

EOF

while true; do
    sleep 1
done
