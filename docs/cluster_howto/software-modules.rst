Using the supported software via modules
****************************************

Running a software or application in Linux requires certain changes on the environment variables.  Some variables are common (such as ``$PATH``, ``$LD_LIBRARY_PATH``), some are application specific (such as ``$R_LIBS`` for R, ``$SUBJECTS_DIR`` for Freesurfer.)

In order to help configure the shell environment for running the supported software, a tool called `Environment Modules <http://modules.sourceforge.net/>`_ is used in the cluster.  Hereafter, we introduce few mostly used ``module`` commands for using the supported software in the cluster.

.. note::
    You should have the ``module`` command available if you login to one of the mentat access node using a SSH client (e.g. putty). In the virtual terminal (i.e. GNOME Terminal or Konsole) of a VNC session, the ``module`` command may not be available immediately. If it happens to you, make sure the following lines are presented in the ``~/.bashrc`` file.

    .. code-block:: bash

        if [ -f /etc/bashrc ]; then
            source /etc/bashrc
        fi

    For example, run the following command in a terminal:

    .. code-block:: bash

        $ echo 'if [ -f /etc/bashrc ]; then source /etc/bashrc; fi' >> ~/.bashrc

    Please note that you should close all existing terminals in the VNC session and start from a new terminal. In the new terminal, you should have the ``module`` command available.

Showing available software
==========================

Firstly, one uses the ``module`` command to list the supported software in the cluster. This is done by the following command:

.. code-block:: bash

    % module avail
    ----------------------------- /opt/_modules --------------------------------------------
    32bit/brainvoyagerqx/1.10.4   cluster/1.0(default)   matlab/7.0.4    mcr/R2011b
    32bit/brainvoyagerqx/1.3.8    cuda/5.0               matlab/7.1.0    mcr/R2012a
    32bit/brainvoyagerqx/1.8.6    cuda/5.5(default)      matlab/R2006a   mcr/R2012b(default)
    32bit/ctf/4.16                dcmtk/3.6.0(default)   matlab/R2006b   mcr/R2013a
    32bit/mricro/1.38_6           fsl/5.0.6              matlab/R2014a   python/2.6.5

    ## ... skip ...

As shown above, the software are represented as modules organised in name and version.  From the list, one selects a software (and version) by picking up a corresponding module. Assuming that we are going to run FSL version 5.0.6, the module to chose is named as ``fsl/5.0.6``.

Tip: Software are installed in a directory with respect to the hierachy of the module names.  For instance, the FSL software corresponding to the module ``fsl/5.0.6`` is installed under the directory ``/opt/fsl/5.0.6``.

Loading software
================

After chosing a module, the next step is to ``load`` it to configure the shell environment accordingly for running the software. This is done via the ``load`` command. For example, to configure ``fsl/5.0.6`` one does

.. code-block:: bash

    % module load fsl/5.0.6

After that, one can check if a right version of the FSL executable is available.  For example,

.. code-block:: bash

    % which fsl
    /opt/fsl/5.0.6/bin/fsl

.. tip::
    You can load more than one module at the same time.

Unloading software
==================

When a loaded software is no longer needed, one can easily rollback the shell environment configuration by unloading the specific module.  For instance,

.. code-block:: bash

    % module unload fsl/5.0.6

As the configuration for running FSL version 5.0.6 is removed, the FSL executable becomes unavailable.  It makes sure that the environment is clean for running other software.

Listing loaded software
=======================

In most of cases, you will load several software in one shell environment. To get an overview on the software loaded in the current shell, one can use the ``list`` option. For example,

.. code-block:: bash

    % module list
    Currently Loaded Modulefiles:
    1) fsl/5.0.6       2) R/3.1.2         3) cluster/1.0     4) matlab/R2012b

Pre-loaded software
===================

Right after logging into the cluster, you will find several pre-loaded software.  You can find them via ``module list`` command. Although you are free to unload them using the ``module unload`` command, you should always keep the module ``cluster/1.0`` loaded as it includes essential configurations for running computations in the cluster.

.. tip::
    You should always keep the ``cluster/1.0`` module loaded.
