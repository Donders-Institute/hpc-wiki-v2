# Getting access to the HPC cluster

## Obtain an user account

You should receive a pair of username/password after following the DCCN's check-in procedure. If you do not have a account, ask the [TG helpdesk](mailto:helpdesk@fcdonders.ru.nl). 

Note: The user account here is **NOT** the account (e.g. u-number) given by the Radboud University. 

## SSH login with Putty

Follow the steps below to connect to one of the cluster's access nodes, using the SSH.

1. Start putty on the Windows desktop
2. Configure putty for connecting to, e.g., `mentat001.dccn.nl` 
3. Login with your username and password 
4. Get a test-based virtual terminal with a shell prompt

Screenshots of the four steps are shown below:

![](figures/start_putty.png)
![](figures/putty_load_session.png)
![](figures/putty_login_username_password.png)
![](figures/putty_login_success.png)

## SSH logout

You can logout the system by either closing the Putty window or typing the command `exit` in the virtual terminal.

## VNC for graphic desktop

> For the first-time user, type
> 
> ```bash
> $ vncpasswd
> ```
> in the putty terminal to protect your VNC server from anonymous access before following the instructions below.

Firstly, start the VNC server by typing the following command in the putty terminal:

```bash
$ vncmanager
```

Follow the step-by-step instructions on the screen to initiate a VNC server. See the screenshots below as an example.

![](figures/vncmanager_main_menu_startvnc.png)
![](figures/vncmanager_startvnc_chosehost.png)
![](figures/vncmanager_startvnc_choseresolution.png)
![](figures/vncmanager_startvnc_adjustscreensize.png)
![](figures/vncmanager_startvnc_chosewm.png)
![](figures/vncmanager_startvnc_success.png)

In the screenshots above, we have started a VNC server associated with a display endpoint `mentat002.dccn.nl:56`.  To connect to it, we use a VNC client called TigerVNC Viewer.  Follow the steps below to make the connection:

1. Open the TigerVNC Viewer (double-click the icon on the desktop)
2. Enter the display endpoint (`mentat002.dccn.nl:56`) as the VNC server
3. Enter the authentication password you set via the `vncpasswd` command
4. Get the graphical desktop of the access node

Note: The display endpoint _mentat002.dccn.nl:56_ is just an example.  In reality, you should replace it with a different endpoint given by the _vncmanager_.

Screenshots of those steps are given below:

![](figures/start_tigerVNC.png)
![](figures/tigerVNC_connect.png)
![](figures/tigerVNC_auth.png)
![](figures/tigerVNC_success.png)

## Disconnect VNC server

To disconnect the VNC server, simply close the TigerVNC-viewer window in which the graphical desktop is displayed. The VNC server will remain available, and can be reused (re-connected) when you need to use the graphical desktop again in the future.

Warning: __DO NOT__ logout the graphical desktop as it causes the VNC server become unaccessible afterwards.

## Terminate VNC server

Since the graphical windows manager takes significant amount of resources from the system, it is strongly recommended to terminate the VNC server if you are not actively using it.  Terminating a VNC server can be done via the `vncmanager` command.  The steps are shown in the screenshots below:

![](figures/vncmanager_stopvnc.png)
![](figures/vncmanager_stopvnc_selectvnc.png)
![](figures/vncmanager_stopvnc_confirm.png)


## Not in the DCCN network 

If you are at home or on travel, or connecting your personal laptop to the edurom network, you are not allowed to connect to the access nodes directly as they are in the DCCN network protected by a firewall.  In this case, you need to make the connection indirectly via the so-called SSH tunnel.

### The SSH tunnel

A SSH gateway named `ssh.fcdonders.nl` is provided for setting the SSH tunnels. When setting up a tunnel for connecting to a target service behind the firewall, one needs to choose a local network port that is still free for use on your desktop/laptop (i.e. the `Source port`) and provides the network endpoint (i.e. the `Destination`) referring to the target service.

Tip: This technique can also be applied for accessing different services protected by the DCCN firewall.

### Instructions in video

The following screencast will guide you through the steps of accessing the cluster via the SSH tunnel.

[](https://youtu.be/mjgDVx_k4dU)

### Putty login via SSH tunnel 
In this example, we choose `Source port` to be `8022`.  The `Destination` referring to the SSH server on mentat001 should be `mentat001:22`.

Follow the steps below to establish the tunnel for SSH connection:

1. Start putty on the Windows desktop
2. Configure putty for connecting to the SSH gateway `ssh.fcdonders.nl`
3. Configure putty to initiate a local port `8022` for forwarding connections to `mentat001:22` 
4. Login the gateway with your username and password to establish the tunnel

![](figures/start_putty.png)
![](figures/putty_ssh_tunnel_gateway_setup.png)
![](figures/putty_ssh_tunnel_for_ssh.png)
![](figures/putty_ssh_tunnel_gateway_login.png)

Keep the login window open and make another SSH connection to the local port as follows:

1. Start putty on the Windows desktop
2. Configure putty for connecting to `localhost` on port `8022`
3. Login with your username and password
4. Get a test-based virtual terminal with a shell prompt

![](figures/start_putty.png)
![](figures/putty_ssh_login_via_tunnel.png)
![](figures/putty_login_username_password.png)
![](figures/putty_login_success.png)

### VNC via SSH tunnel
In this example, we choose `Source port` to be `5956`.  We also assume that a VNC server has been started on `mentat002` with the display number `56`. The `Destination` referring to the VNC server should be ``mentat002:5956``.

Note: The display number _56_ is just an example.  In reality, you should replace it with a different number assigned by the _vncmanager_.  Nevertheless, the network port number is always the display number plus _5900_.

Follow the steps below to establish the tunnel for VNC connection:

1. Start putty on the Windows desktop
2. Configure putty for connecting to the SSH gateway `ssh.fcdonders.nl`
3. Configure putty to initiate a local port `5956` for forwarding connections to `mentat002:5956` 
4. Login the gateway with your username and password to establish the tunnel

![](figures/start_putty.png)
![](figures/putty_ssh_tunnel_gateway_setup.png)
![](figures/putty_ssh_tunnel_for_vnc.png)
![](figures/putty_ssh_tunnel_gateway_login.png)

Keep the login window open and make VNC client connection to the local port as follows:

1. Open TigerVNC application 
2. Enter the display endpoint (`localhost:5956`) as the VNC server
3. Enter the authentication password you set via the `vncpasswd` command
4. Get the graphical desktop of the access node

![](figures/start_tigerVNC.png)
![](figures/tigerVNC_via_tunnel.png)
![](figures/tigerVNC_auth.png)
![](figures/tigerVNC_success.png)
