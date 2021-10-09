#!/usr/bin/pwsh

$vncserver = Read-Host -Prompt "vncserver"
$username = Read-Host -Prompt "username"

$vnchost = $vncserver.split(":")[0]
$vncport = [int]$vncserver.split(":")[1]

if ($vncport -lt 100) {
    $vncport = $vncport + 5900
}

$socket = $vncport

$openssl = $true

if ( Get-command ssh) {
    # OpenSSH: create SSH tunnel in background with a control socket
    ssh -M -S $socket -fNT -L ${vncport}:${vnchost}:${vncport} ${username}@ssh.dccn.nl

    Write-Host "tunnel ${socket} created"
    Write-Host ""
    Write-Host "Keep this terminal open and use VNC client to connect localhost:${vncport}, or"
    Write-Host "use Ctrl-C to close the tunnel."

    try {
        while($true) {}
    } finally {
        # close up the SSH tunnel
        ssh -S $socket -O exit ${username}@ssh.dccn.nl
    }
} elseif ( Get-command putty.exe ) {
    # Putty
    Write-Host ""
    Write-Host "After login with Putty, keep the Putty terminal open and use VNC client to connect localhost:${vncport}, or"
    Write-Host "close the Putty terminal to stop the tunnel."

    Start-Process -FilePath putty.exe -ArgumentList "-ssh ${username}@ssh.dccn.nl -L ${vncport}:${vnchost}:${vncport}" -Wait
} else {
    Write-Error "ssh client not available"
}


