Using SSH tunnel
****************

A SSH gateway named ``ssh.dccn.nl`` is provided for setting the SSH tunnels. When setting up a tunnel for connecting to a target service behind the firewall, one needs to choose a local network port that is still free for use on your desktop/laptop (i.e. the ``Source port``) and provides the network endpoint (i.e. the ``Destination``) referring to the target service.

.. tip::
   This technique can also be applied for accessing different services protected by the DCCN firewall.

.. contents:: Contents
   :local:

Instructions in video
=====================

The following screencast will guide you through the steps of accessing the cluster via the SSH tunnel.

.. raw:: html

   <iframe width="560" height="315" src="https://www.youtube.com/embed/mdEnaDrpux8" frameborder="0" allowfullscreen></iframe>

Utility script
==============

For your convenience, we made an utility script to simplfy the setup of a SSH tunnel (for both VNC and data transfer).  Nevertheless, we recommend to understand the mechanism by going through the steps once.

- tunnel2vnc script [`Windows <_static/tunnel2vnc/tunnel2vnc.ps1>`_] [`Linux/MacOSX <_static/tunnel2vnc/tunnel2vnc.sh>`_]

For the usage of the script, see the tips in :ref:`vnc_ssh_tunnel_windows` and :ref:`vnc_ssh_tunnel_linux_mac`.

Putty login via SSH tunnel
==========================

In this example, we choose ``Source port`` to be ``8022``.  The ``Destination`` referring to the SSH server on mentat001 should be ``mentat001:22``.

Follow the steps below to establish the tunnel for SSH connection:

#. start putty on the Windows desktop

   .. figure:: figures/start_putty.png
      :figwidth: 60%

#. configure putty for connecting to the SSH gateway ``ssh.fcdonders.nl``

   .. figure:: figures/putty_ssh_tunnel_gateway_setup.png
      :figwidth: 60%

#. configure putty to initiate a local port ``8022`` for forwarding connections to ``mentat001:22``

   .. figure:: figures/putty_ssh_tunnel_for_ssh.png
      :figwidth: 60%

#. login the gateway with your username and password to establish the tunnel

   .. figure:: figures/putty_ssh_tunnel_gateway_login.png
      :figwidth: 60%

Once you have logged in the gateway, you should keep the login window open; and make another SSH connection to the local port as follows:

#. start another putty on the Windows desktop

   .. figure:: figures/start_putty.png
      :figwidth: 60%

#. configure putty for connecting to ``localhost`` on port ``8022``.  This is the port we initiated when establishing the tunnel.

   .. figure:: figures/putty_ssh_login_via_tunnel.png
      :figwidth: 60%

#. login with your username and password

   .. figure:: figures/putty_login_username_password.png
      :figwidth: 60%

#. get the virtual terminal with a shell prompt.  You should see the hostname ``mentat001`` showing on the prompt.

   .. figure:: figures/putty_login_success.png
      :figwidth: 60%

.. _vnc_ssh_tunnel_windows:

VNC via SSH tunnel (Windows)
============================

.. tip::
   A simple script wrapping up the steps below can be found `here </_static/tunnel2vnc/tunnel2vnc.ps1>`_.  After downloading the file, right-click the file to run with Powershell and follow the instruction to setup the tunnel.

   If the Powershell program closed immediately after you run the script, you might need to set the Powershell execution policy.  Open the Powershell as the Administrator and run

   .. code:: powershell

      > Set-ExecutionPolicy -ExecutionPolicy Unrestricted
   
In this example, we choose ``Source port`` to be ``5956``.  We also assume that a VNC server has been started on ``mentat002`` with the display number ``56``. The ``Destination`` referring to the VNC server should be ``mentat002:5956``.

.. note::
    The display number ``56`` is just an example.  In reality, you should replace it with a different number assigned by the *vncmanager*.  Nevertheless, the network port number is always the display number plus ``5900``.

Follow the steps below to establish the tunnel for VNC connection:

#. start putty on the Windows desktop

   .. figure:: figures/start_putty.png
      :figwidth: 60%

#. configure putty for connecting to the SSH gateway ``ssh.fcdonders.nl``

   .. figure:: figures/putty_ssh_tunnel_gateway_setup.png
      :figwidth: 60% 

#. configure putty to initiate a local port ``5956`` for forwarding connections to ``mentat002:5956``

   .. figure:: figures/putty_ssh_tunnel_for_vnc.png
      :figwidth: 60%

#. login the gateway with your username and password to establish the tunnel

   .. figure:: figures/putty_ssh_tunnel_gateway_login.png
      :figwidth: 60%

Once you have logged in the gateway, you should keep the login window open; and maken a VNC client connection to the local port as follows:

#. open the TigerVNC application

   .. figure:: figures/start_tigerVNC.png
      :figwidth: 60%

#. enter the display endpoint (``localhost:5956``) as the VNC server

   .. figure:: figures/tigerVNC_via_tunnel.png
      :figwidth: 60%

#. enter the authentication password you set via the ``vncpasswd`` command

   .. figure:: figures/tigerVNC_auth.png
      :figwidth: 60%

#. get the graphical desktop of the access node

   .. figure:: figures/tigerVNC_success.png
      :figwidth: 60%

.. _vnc_ssh_tunnel_linux_mac:

VNC via SSH tunnel (Linux/Mac OSX)
==================================

.. tip::
   A simple script wrapping up the steps below can be found `here </_static/tunnel2vnc/tunnel2vnc.sh>`_.  Open a terminal and use the command below to download the script to setup the SSH tunnel:

   .. code:: bash

      $ curl -o $HOME/tunnel2vnc https://dccn-hpc-wiki.readthedocs.io/en/latest/_static/tunnel2vnc/tunnel2vnc.sh
      $ chmod +x $HOME/tunnel2vnc

   Run the command below in a terminal to start a SSH tunnel for VNC:

   .. code:: bash

      $ $HOME/tunnel2vnc
      
   and follow the instruction to setup the tunnel.

In this example, we choose ``Source port`` to be ``5956``.  We also assume that a VNC server has been started on ``mentat002`` with the display number ``56``. The ``Destination`` referring to the VNC server should be ``mentat002:5956``.

.. note::
   The display number ``56`` is just an example.  In reality, you should replace it with a different number assigned by the *vncmanager*.  Nevertheless, the network port number is always the display number plus ``5900``.

Follow the steps below to establish the tunnel for VNC connection:

#. open a terminal application

   On Linux, this can be either `gnome-terminal` on GNOME desktop environment, `xfce4-terminal` on the XFCE4, or `konsole` of the KDE.  On Mac, the `Terminal` app can be found in the `Other` group under the app lanchpad.
   
#. set up the SSH tunnel

   Use the following command to create the SSH tunnel.  Note that the ``$`` sign is just an indication of your terminal prompt, it is not the part of the command.  The username ``xxxyyy`` should also be your actual DCCN account name in practice.
   
   .. code:: bash
      
      $ ssh -L 5956:mentat002:5956 xxxyyy@ssh.dccn.nl
      
   A screenshot below shows an example:
   
   .. figure:: figures/terminal_ssh_tunnel.png
      :figwidth: 60%
   
   Once the connect is set, you should leave the terminal open.  If you close the terminal, the tunnel is also closed.  You can now make a connection to your VNC session through this SSH tunnel.
   
#. open the TigerVNC application

   .. figure:: figures/start_tigerVNC_macosx.png
      :figwidth: 60%

#. enter the display endpoint (``localhost:5956``) as the VNC server

   .. figure:: figures/tigerVNC_via_tunnel_macosx.png
      :figwidth: 60%

#. enter the authentication password you set via the ``vncpasswd`` command

   .. figure:: figures/tigerVNC_auth_macosx.png
      :figwidth: 60%

#. get the graphical desktop of the access node

   .. figure:: figures/tigerVNC_success_macosx.png
      :figwidth: 60%
