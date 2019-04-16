Exercise: Using the environment modules to setup data-analysis software
***********************************************************************

In this exercise we will learn few useful commands for setting up data-analysis software in the cluster using the `environment modules <http://modules.sourceforge.net>`_.  Environment modules are helpful in organising software, and managing environment variables required by running the software.

The tasks below use the software R to illustrate the general idea that is applicable to setup other data-analysis software installed in the cluster.

.. note::
    DO NOT just copy-n-paste the commands for the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

Tasks
=====

#. List the configured software

   The following command is used to check what are software currently configure/setup in your shell environment:

   .. code-block:: bash

        $ module list
        Currently Loaded Modulefiles:
        1) cluster/1.0      3) matlab/R2018b    5) freesurfer/6.0
        2) project/1.0      4) R/3.5.1          6) fsl/6.0.0

   Configured software is listed in terms of the **loaded modules**.

   You probably notice a message similar to the one above in the terminal after you login to the cluster's access node.  This message informs you about the pre-loaded environment modules.  It implies that your bash shell has been configured with proper environment variables (e.g. ``PATH``) for running those software/version right away after the login.

#. List available software

   .. code-block:: bash

        $ module avail

   Environment modules for the software are organised in software names and versions.

#. List available versions of R

   .. code-block:: bash

        $ module avail R

   You may replace ``R`` with ``matlab``, ``freesurfer`` or ``fsl`` to see versions of different software.

#. Show the changes in environment variables w.r.t. the setup for R version 3.2.2

   .. code-block:: bash

        $ module show R/3.2.2

#. Check current value of the ``$R_HOME`` environment variable

   .. code-block:: bash

        $ echo $R_HOME
        /opt/R/3.1.2

   As the default R version, the ``$R_HOME`` variable is set to point to version 3.1.2.

#. Setup the environment for R version 3.2.2

   Firstly, unload the default R with

   .. code-block:: bash

        $ module unload R

   , and load the specific R version with

   .. code-block:: bash

        $ module load R

   Following to it, check the ``$R_HOME`` variable again, it should be pointed to a directory where the version 3.2.2 is installed. You should be ready to use R version 3.2.2 in the cluster.

   .. code-block:: bash

        $ echo $R_HOME

#. Don't like 3.2.2 and want to switch to 3.3.1 ... Do you know how to do it?
