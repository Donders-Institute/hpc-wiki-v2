Using the Visual Studio Code
****************************************

`Visual Studio Code (VSCode) <https://code.visualstudio.com/docs/introvideos/basics>`_ is a cross-platform source-code editor made by Microsoft. Features include support for debugging, syntax highlighting, intelligent code completion, snippets, code refactoring, and embedded Git. This tutorial provides instructions for using the Visual Studio Code Remote - a VSCode extension connecting your local VSCode to the cluster server. 

Prerequisites
-------------
Before proceeding, make sure you have the following:

1. A `Github <https://github.com/login>`_ account.
2. Installed `Visual Studio Code <https://code.visualstudio.com/download>`_ on your local machine.
3. Knowledge of :doc:`VNC for graphic desktop <access-internal>`.
4. Knowledge of :doc:`Running Interactive job <exercise_interactive/exercise>`.


Setting the 'code' CLI (On DCCN's server)
------------------------------
This step will teach you how to install the code CLI on your DCCN's login node. This CLI will establish a tunnel between a VS Code client and your remote machine.

1. Login using VNC and start a Terminal. Download the `standalone CLI <https://code.visualstudio.com/#alt-downloads>`_ in Linux x64. After running the following code you'll get a binary file named 'code' in your directory.

  .. code-block:: bash

      $ curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
      $ tar -xf vscode_cli.tar.gz

  .. figure:: figures/vscode_download_cli.png
      :figwidth: 100%
      :align: center

2. Start the VSCode tunnel through following command:

  .. code-block:: bash

      $ ./code tunnel

3. Login with you github account:

  .. figure:: figures/vscode_cli_login.png
      :figwidth: 100%
      :align: center

4. If success, you'll see a link. You can now paste the link into your local browser and open VSCode from your laptop. Note that you only have to do this once. Be sure to leave this terminal open to maintain the tunnel forwarding.

  .. figure:: figures/vscode_success_login.png
      :figwidth: 100%
      :align: center


Using the 'code' CLI (On DCCN's server)
------------------------------
You can also use the code CLI inside the computational node.

1. Start an Interactive job.
2. Repeat the above steps 2-4. You can now using VScode inside the computational node.


Using the the VSCode Remote Extension (On 'your' local VSCode)
--------------------------
You can install and use the `Remote - Tunnels` extension on your local (Ex: personal laptop) to connect to remote machines with active tunnels. 
To connect to a remote machine using the extension, follow these steps:

1. Install the `Remote - Tunnels extension <https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server>`_.
2. In the VS Code Account menu, select the option to Turn on Remote Tunnel Access, as demonstrated in the image below. You may also open the Command Palette (F1) in VS Code and run the command Remote Tunnels: Turn on Remote Tunnel Access....

  .. figure:: figures/vscode_turn_on_remote_tunnel.png
      :figwidth: 100%
      :align: center
   
3. You'll be prompted to log into GitHub. Once you're logged, you'll be able to connect to your remote machine.


References
----------------
For more information and detailed instructions, refer to the official documentation [1].

[1] https://code.visualstudio.com/docs/remote/tunneling
