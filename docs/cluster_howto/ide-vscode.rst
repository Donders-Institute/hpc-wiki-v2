.. _ide_vscode:

Using the Visual Studio Code
****************************

`Visual Studio Code (VSCode) <https://code.visualstudio.com/docs/introvideos/basics>`_ is a cross-platform source-code editor made by Microsoft. Features include support for debugging, syntax highlighting, intelligent code completion, snippets, code refactoring, and embedded Git.

This tutorial provides instructions for using the Visual Studio Code Remote - a VSCode extension connecting your local VSCode to the cluster server.

Prerequisites
-------------
Before proceeding, make sure you have the following:

#. A `Github <https://github.com/login>`_ account.
#. Installed `Visual Studio Code <https://code.visualstudio.com/download>`_ on your local machine.
#. Knowledge of :doc:`VNC for graphic desktop <access-internal>`.
#. Knowledge of :doc:`Running Interactive job <exercise_interactive/exercise>`.

Running the 'code' CLI (On DCCN's server)
-----------------------------------------

This step will setup and run the code CLI via an interactive job on the cluster. This CLI will establish a tunnel enabling code changing, testing and debugging on the cluster from a VSCode graphical interface running on your local computer. 

1. Login using VNC and start a Terminal. Download the `standalone CLI <https://code.visualstudio.com/#alt-downloads>`_ in Linux x64. After running the following code you'll get a binary file named 'code' in your home directory.

  .. code-block:: bash

      $ cd
      $ curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
      $ tar -xf vscode_cli.tar.gz

  .. figure:: figures/vscode_download_cli.png
      :figwidth: 100%
      :align: center

2. Start an interactive job with required resources, e.g.

  .. code-block:: bash

      $ qsub -I -l walltime=12:00:00,mem=8gb

3. At the prompt of the interactive job, start the VSCode tunnel through following command:

  .. code-block:: bash

      $ module load apptainer
      $ singularity exec /opt/singularity/images/code_cli.sif `pwd`/code tunnel

  The idea of loading the vscode binary from within the singularity container is to provide the up-to-date glibc library required by the vscode server.  The container image ``/opt/singularity/images/code_cli.sif`` provides glibc 2.35 via Ubuntu 22.04.

4. Login with you github account:

  .. figure:: figures/vscode_cli_login.png
      :figwidth: 100%
      :align: center

5. If success, you'll see a link. You can now paste the link into your local browser and open VSCode from your laptop. Note that you only have to do this once. Be sure to leave this terminal open to maintain the tunnel forwarding.

  .. figure:: figures/vscode_success_login.png
      :figwidth: 100%
      :align: center

Once the interactive job is finished or killed after running out of the walltime, the tunnel will also be closed.  The tunnel can be restarted by repeating step 2 and 3 mentioned above.

Using the the VSCode Remote Extension (On 'your' local VSCode)
--------------------------------------------------------------

You can install and use the `Remote - Tunnels` extension on your local (e.g. personal laptop) to connect to remote machines with active tunnels.

To connect to a remote machine using the extension, follow these steps:

1. Install the `Remote - Tunnels extension <https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server>`_.

2. In the VS Code Account menu, select the option to Turn on Remote Tunnel Access, as demonstrated in the image below. You may also open the Command Palette (F1) in VS Code and run the command Remote Tunnels: Turn on Remote Tunnel Access....

  .. figure:: figures/vscode_turn_on_remote_tunnel.png
      :figwidth: 100%
      :align: center
   
3. You'll be prompted to log into GitHub. Once you're logged, you'll be able to connect to your remote machine.

References
----------
For more information and detailed instructions, refer to the official documentation [1].

[1] https://code.visualstudio.com/docs/remote/tunneling
