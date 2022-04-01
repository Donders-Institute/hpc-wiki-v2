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

Function Write-ErrorMessage {
      [CmdletBinding(DefaultParameterSetName='ErrorMessage')]
      param(
           [Parameter(Position=0,ParameterSetName='ErrorMessage',ValueFromPipeline,Mandatory)][string]$errorMessage
           ,[Parameter(ParameterSetName='ErrorRecord',ValueFromPipeline)][System.Management.Automation.ErrorRecord]$errorRecord
           ,[Parameter(ParameterSetName='Exception',ValueFromPipeline)][Exception]$exception
      )

      switch($PsCmdlet.ParameterSetName) {
      'ErrorMessage' {
           $err = $errorMessage
      }
      'ErrorRecord' {
           $errorMessage = @($error)[0]
           $err = $errorRecord
      }
      'Exception'   {
           $errorMessage = $exception.Message
           $err = $exception
      }
      }

      Write-Error -Message $err -ErrorAction SilentlyContinue
      $Host.UI.WriteErrorLine($errorMessage)
};

# input for vncserver endpoint (host:display or host:port)
$vncserver = Read-Host -Prompt "vncserver (hostname:displaynumber)"

# resolve host and port of the vncserver
$vnchost = $vncserver.split(":")[0]
$vncport = [int]$vncserver.split(":")[1]
if ($vncport -lt 100) {
    $vncport = $vncport + 5900
}

# vncport at this point should be between 5901 and 5999
if ( $vncport -lt 5901 -Or $vncport -gt 5999 ) {
    Write-ErrorMessage "invalid VNC server"
    Read-Host -Prompt "press any key to close"
    Exit
}

$ftpport = $vncport + 1000

# set current terminal title
$host.ui.RawUI.WindowTitle = "tunnel2vnc [${vncport}]"

# input for ssh gateway username
$username = Read-Host -Prompt "DCCN username"

# try to include Paths where the PuTTY or OpenSSH are possibility installed
$Env:Path += ";${Env:ProgramFiles}\PuTTY;${Env:ProgramFiles(x86)}\PuTTY;${Env:ProgramFiles}\OpenSSH"

if ( Get-command plink.exe ) { # default option: Putty
    Write-Connection-Info -VncPort ${vncport} -FtpPort ${ftpport}
    # start plink, commandline putty
    Start-Process -FilePath plink.exe -ArgumentList "-ssh ${username}@ssh.dccn.nl -t -N -L ${vncport}:${vnchost}:${vncport} -L ${ftpport}:${vnchost}:22" -NoNewWindow -Wait

} elseif ( Get-command ssh) { # second option: OpenSSH (To be tested)
    Write-Connection-Info -VncPort ${vncport} -FtpPort ${ftpport}
    # create SSH tunnel in background with a control socket (not sure if socket works on Windows??)
    $socket = $vncport
    ssh -M -S $socket -fNT -o ExitOnForwardFailure=yes -L ${vncport}:${vnchost}:${vncport} -L ${ftpport}:${vnchost}:22 -p 10990 ${username}@ssh.dccn.nl
    if ( ${LastExitCode} -ne 0 ) {
        Write-ErrorMessage "fail to setup tunnel"
        Read-Host -Prompt "press any key to close"
        Exit
    }
    try {
        while($true) {}
    } finally {
        # close up the SSH tunnel
        ssh -S $socket -O exit ${username}@ssh.dccn.nl
    }
} else {
    Write-ErrorMessage "no ssh client found"
    Read-Host -Prompt "press any key to close"
    Exit
}
