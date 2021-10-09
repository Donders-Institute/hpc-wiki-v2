#!/usr/bin/pwsh
function Write-Connection-Info {

    param (
        [Parameter(Mandatory = $true)] [Int32] $VncPort,
        [Parameter(Mandatory = $true)] [Int32] $FtpPort
    )

    Write-Host ""
    Write-Host "!! After login below, keep this terminal open !!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "- for VNC: connect VNC client to localhost:${VncPort}" -ForegroundColor Green
    Write-Host "- for data transfer: connect SFTP client to localhost:${FtpPort}" -ForegroundColor Green
    Write-Host "- use Ctrl-C to close the tunnel." -ForegroundColor Green
    Write-Host ""    
}

# input for vncserver endpoint (host:display or host:port)
$vncserver = Read-Host -Prompt "vncserver"

# resolve host and port of the vncserver
$vnchost = $vncserver.split(":")[0]
$vncport = [int]$vncserver.split(":")[1]
if ($vncport -lt 100) {
    $vncport = $vncport + 5900
}
$ftpport = $vncport + 1000

# set current terminal title
$host.ui.RawUI.WindowTitle = "tunnel2vnc [${vncport}]"

# input for ssh gateway username
$username = Read-Host -Prompt "username"

if ( Get-command plink.exe ) { # default option: Putty
    Write-Connection-Info -VncPort ${vncport} -FtpPort ${ftpport}
    # start plink, commandline putty
    Start-Process -FilePath plink.exe -ArgumentList "-ssh ${username}@ssh.dccn.nl -L ${vncport}:${vnchost}:${vncport} -L ${ftpport}:${vnchost}:22" -NoNewWindow -Wait

} elseif ( Get-command ssh) { # second option: OpenSSH (To be tested)
    Write-Connection-Info -VncPort ${vncport} -FtpPort ${ftpport}
    # create SSH tunnel in background with a control socket (not sure if socket works on Windows??)
    $socket = $vncport
    ssh -M -S $socket -fNT -L ${vncport}:${vnchost}:${vncport} -L ${ftpport}:${vnchost}:22 ${username}@ssh.dccn.nl
    try {
        while($true) {}
    } finally {
        # close up the SSH tunnel
        ssh -S $socket -O exit ${username}@ssh.dccn.nl
    }
} else {
    Write-Error "no ssh client found"
}