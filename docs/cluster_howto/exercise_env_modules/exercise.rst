Exercise: Using the environment modules to setup data-analysis software
***********************************************************************

In this exercise we will learn few useful commands for setting up data-analysis software in the cluster using the `environment modules <http://modules.sourceforge.net>`_.  Environment modules are helpful in organising software, and managing environment variables required by running the software.

The tasks below use the software R to illustrate the general idea that is applicable to setup other data-analysis software installed in the cluster.

.. note::
    DO NOT just copy-n-paste the commands for the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

Tasks
=====

1. List the configured software

    The following command is used to check what are software currently configure/setup in your shell environment:

    .. code-block:: bash

        $ module list
        Currently Loaded Modulefiles:
        1) cluster/1.0            4) freesurfer/5.3         7) brainvoyagerqx/2.3.1
        2) matlab/R2012b          5) fsl/5.0.9              8) rsi/idl/7.0
        3) R/3.1.2                6) mricron/201506

    Configured software is listed in terms of the **loaded modules**.

    You probably notice a message similar to the one above in the terminal after you login to the cluster's access node.  This message informs you about the pre-loaded environment modules.  It implies that you can run those software/version right away after the login.

2. List available software

    .. code-block:: bash

        $ module avail

    Environment modules for the software are organised in software names and versions.

3. List available versions of R

    .. code-block:: bash

        $ module avail R

    You may replace ``R`` with ``matlab``, ``freesurfer`` or ``fsl`` to see versions of different software.

4. Show the changes in environment variables w.r.t. the setup for R version 3.2.2

    .. code-block:: bash

        $ module show R/3.2.2

5. Check current value of the ``$R_HOME`` environment variable

    .. code-block:: bash

        $ echo $R_HOME
        /opt/R/3.1.2

    As the default R version, the ``$R_HOME`` variable is set to point to version 3.1.2.

6. Setup the environment for R version 3.2.2

    Firstly, unload the default R with

    .. code-block:: bash

        $ module unload R

    and load the specific R version with

    .. code-block:: bash

        $ module load R

    Following to it, check the ``$R_HOME`` variable again, it should be pointed to a directory where the version 3.2.2 is installed. You should be ready to use R version 3.2.2 in the cluster.

    .. code-block:: bash

        $ echo $R_HOME

7. Don't like 3.2.2 and want to switch to 3.3.1 ... Do you know how to do it?
