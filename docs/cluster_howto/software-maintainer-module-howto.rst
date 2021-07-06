.. _software-maintainer-module-howto:

How to maintain software modules in the HPC cluster
****************************************************

In the HPC cluster, commonly used software that is not part of the standard Linux system is installed in a centrally managed software repository. The repository is mounted on the access (`mentat001 ~ mentat005`) and compute nodes under the ``/opt`` directory. The user enables a specific software package using the module command, e.g., with ``module add R/3.4.0``.

Installing software and organizing versions
============================================

Within ``/opt``, each software package is organized in a separate sub-directory. The maintainer of a specific software package has the owner permission of that sub-directory. Thus, before you can install software under the ``/opt`` directory, you need to be the maintainer of the software and take the :ref:`software-maintainer` responsibility.

The maintainer installs software and organizes versions. An example file system tree structure below shows how different versions of the software `R` is organized.

.. code-block:: bash

    /opt/R
    |-- 3.1.2
    |-- 3.2.0
    |-- 3.2.2
    |-- 3.3.1
    |-- 3.3.2
    |-- 3.3.3
    |-- 3.4.0
    |-- 3.5.1
    `-- 4.0.1

.. tip::

    For software installed via `GNU autoconf <https://www.gnu.org/software/autoconf/autoconf.html>`_ (i.e. the installation consists of steps of ``configure``,  ``make``,  ``make install``), you can use the ``--prefix`` to specify the installation destination in the configure step.

Making software available via environment modules
==================================================

In the cluster, we use the `environment modules <https://modules.readthedocs.io/en/latest/>`_ for controlling the path and (un-)setting software-specific environmental variables. Next to the installation, the maintainer should therefore also create a script for the environment modules. Those module scripts are organized under the ``/opt/_modules`` directory.

Within ``/opt/_modules``, each software has its own sub-directory within which module scripts referring to different versions are arranged. An example below shows the file-system tree structure of module scripts for the software `R`.

.. code-block:: bash

    /opt/_modules/R
    |-- .common
    |-- .version
    |-- 3.1.2 -> .common
    |-- 3.2.0 -> .common
    |-- 3.2.2 -> .common
    |-- 3.3.1 -> .common
    |-- 3.3.2 -> .common
    |-- 3.3.3 -> .common
    |-- 3.4.0 -> .common
    |-- 3.5.1 -> .common
    |-- 4.0.1 -> .common
    `-- common.tcl

Module scripts are written in the `TCL language <https://www.tcl.tk/about/language.html>`_. To lower the barrier of writing the module scripts, the common (and complex) part has been factored out and is shared. The maintainer only needs to follow the steps below to write the package-specific part.

.. note::

    The steps below assume that the first version (1.0.0) of a new software package is installed under ``/opt/new_software/1.0.0``.

#. create a module for new software

    For a newly introduced software, you can initiate the module scripts by, for example, copying the R module scripts. Given an example that the new software is installed in ``/opt/new_software/1.0.0``, you would do

    .. code-block:: bash

        $ cd /opt/_modules/new_software 
        $ cp /opt/_modules/R/common.tcl .
        $ cp /opt/_modules/R/.version .
        $ cp /opt/_modules/R/.common .

    The three files we have copied are described below:

    * ``common.tcl`` is a TCL script containing software-specific configuration. It is the main file the maintainer should modify. It consists of environmental variables needed for users to run the software. For example, extend ``PATH`` for system shell to locate the software's executables. It also contains few metadata for describing the software.
    
    * ``.version`` specifies the default version of the software. It is the version to be loaded if user skips version when loading the module. This file is optional; and if it is not presented, the one (within the software sub-directory, e.g. ``/opt/new_software``) with the highest alphabetical value is used as the default.

    * ``.common`` is the main module script that combines common settings shared among all software modules and the software-specific settings defined in the ``common.tcl`` file. By design, the maintainer should not need to modify it.

#. modify ``common.tcl``

    The complete and official guide for writing module scripts is here. Hereafter is a very simple example of ``common.tcl`` for R:

    .. code-block:: tcl
        :linenos:

        #!/bin/env tclsh

        set appname R
        set appurl "http://www.r-project.org/"
        set appdesc "a free software programming language and software environment for statistical computing and graphics.
        
        The package can be upgraded on user request or maximally within half a year after a new release. The default version is always set to the latest installed version.
        
        You can ask questions / seeks for previous answers in:
            https://mattermost.socsci.ru.nl/dccn/channels/R
        
        This package is maintained by [..]."
        
        ## require $version variable to be set
        module-whatis [WhatIs]
        
        ## make sure only one R is loaded at a time
        if { [ module-info mode load ] } {
            if { [is-loaded R] && ! [is-loaded R/$version] } {
                module unload R
            }
            if { [string match "4*" $version] } {
                module load gcc
            }
        }

        setenv R_HOME $env(DCCN_OPT_DIR)/R/$version/lib64/R
        prepend-path PATH "$env(DCCN_OPT_DIR)/R/$version/bin"
        prepend-path MANPATH "$env(DCCN_OPT_DIR)/R/$version/share/man"

    The first three set statements specify the three variables used for describing the software. They are also automatically displayed on the `HPC software list <https://intranet.donders.ru.nl/index.php?id=torque-software>`_ page of the DCCN intranet.

    #. ``appname`` is the name of the software.
    #. ``appurl`` is the home (or a representative) page URL of the software.
    #. ``appdesc`` is for a short description of the application and should mention the upgrade and default version policy. If possible, the user should be pointed to a support entry point. Note that only the first line of the description will be displayed on the `HPC software list <https://intranet.donders.ru.nl/index.php?id=torque-software>`_ intranet page.

    The last three lines are about setting environmental variables so that when this module is loaded, the shell will:

    #. acquire a new variable R_HOME with the value set to ``$env(DCCN_OPT_DIR)/R/$version/lib64/R``,
    #. prepend path ``$env(DCCN_OPT_DIR)/R/$version/bin`` to the ``PATH`` variable, and
    #. prepend path ``$env(DCCN_OPT_DIR)/R/$version/share/man`` to the ``MANPATH`` variable.

    In most cases, you will extend the PATH variable and add application-specific variables for the software, which can be achieved by using the ``prepend-path`` and ``setenv`` `predefined sub-commands <https://modules.readthedocs.io/en/latest/module.html#module-sub-commands>`_ of the environment modules.

    Note the two variables ``$env(DCCN_OPT_DIR)`` and ``$version`` used in this script. They are variables made available to the module file for referring to the top-level directory of the software repository (``/opt`` in this case) and the version of the software the user is (un-)loading, respectively.

    In this example, the if statement is to resolve version conflict by unloading the already loaded R versions (if it presents) and load a required module (i. e. gcc) when loading certain R versions. More logic can be implemented with `the predefined sub-commands <https://modules.readthedocs.io/en/latest/module.html#module-sub-commands>`_ of the environment modules.

#. expose the module with version

    This step is to make a symbolic link to the ``.common`` file. The link name should reflect the software version. For instance, if the new software version is ``1.0.0``, one does

    .. code-block:: bash

        $ ln -s .common 1.0.0

    After you have the module script setup once, adding module for a new version is usually as simple as making another symbolic to the same .common file. For example, after installing version ``2.0.0`` of the software to repository, you just do:

    .. code-block:: bash

        $ ln -s .common 2.0.0

#. set default version

    Setting the default version is done by the ``.version`` file. Hereafter is an example:

    .. code-block:: tcl

        #%Module1.0#####################################################################
        ##
        ## version file for new_software
        ##
        set ModulesVersion  "1.0.0"

    What you need to change is the value of ``ModulesVersion`` to the name of one of the symlinks made in the previous step. You should keep the header line (i.e. the first line) unchanged.
    
    In the example above, when a user loads the module for ``new_software`` without specifying a version, version ``1.0.0`` will be loaded.

    .. tip::

        You are suggested to set the latest version as the default.
    
        Always communicate with users via email or the HPC Mattermost channel when the default version is changed.