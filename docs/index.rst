High Performance Computing for Neuroimaging Research
****************************************************

.. list-table::
   :widths: 50 50
   :align: center

   * - .. figure:: DCCN_HPC_architecture.svg
          :scale: 60%
          :alt: DCCN HPC environment with SSH/VNC
          :align: center

          DCCN HPC environment with clients using SSH/VNC access

     - .. figure:: DCCN_HPC_architecture-ood.svg
          :scale: 60%
          :alt: DCCN HPC environment with Open OnDemand
          :align: center

          DCCN HPC environment with clients using Web access

HPC Cluster
===========

The HPC cluster at DCCN consists of two groups of computers, they are:

* **access nodes**: ``mentat001`` ~ ``mentat007`` as login nodes.
* **compute nodes**: a pool of powerful computers with more than 1000 CPU cores.

Computer nodes are managed by the `Slurm <https://slurm.schedmd.com/overview.html>`_ job scheduler.

While SSH login and running VNC sessions on the access nodes aresupported, users are encouraged to use `the web interface <https://compute.dccn.nl>`_ for a more modern and user-friendly experience.

Central Storage
===============

The central storage provides a shared file system amongst the Windows desktops within DCCN and the computers in the HPC cluster.

On the central storage, every user has a personal folder with a so-called office quota (50 gigabytes by default).  This personal folder is referred to as the ``M:\`` drive on the Windows desktops.

Storage spaces granted to research projects (following the `project proposal meeting(PPM) <http://intranet.donders.ru.nl/index.php?id=4502>`_) are also provided by the central storage.  The project folders are organised under the directory ``/project`` which is referred to as the ``P:\`` drive on the Windows desktops.

The central storage also hosts a set of commonly used software/tools for neuroimaging data processing and analysis.  This area in the storage is only accessible for computers in the HPC cluster as software/tools stored there require the Linux operating system.

Identity Manager
================

The identity manager maintains information for authenticating users accessing to the HPC cluster. It is also used to check users' identity when logging into the Windows desktops at DCCN. In fact, the user account received from `the DCCN check-in proceduer <https://intranet.donders.ru.nl/index.php?id=4465>`_ is managed secretely by this identity manager.

.. note::
    The user account concerned here (and throughout the entire wiki) is the one received via the DCCN check-in procedure.  It is, in most of cases, a combination of **the first three letters of your first name and the first three letters of your last name**.  It is **NOT** the account from the Radboud University or Radboudumc.

Supported Software
==================

Commonly used software/tools for neuroimaging data processing and analysis are installed on the central storage and accessible to users in the HPC cluster. One can list the available software/tools using the following `Environment Modules <https://modules.readthedocs.io/en/latest/>`_ commands:

.. code-block:: bash

    module avail
