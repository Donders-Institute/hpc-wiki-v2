Exercise: Running FreeSurfer jobs on the cluster
************************************************

In this exercise we will construct a small script to run FreeSurfer's ``recon-all``, and use ``qsub`` to submit this script to the cluster for execution.

Preparation
===========

Move into the directory you'd like to work in and download :download:`the files prepared for the exercise <FSdata.tgz>` using this command:

.. code-block:: bash

    $ wget http://dccn-hpc-wiki.rtfd.io/en/latest/_downloads/FSdata.tgz
    $ tar -xvf FSdata.tgz
    $ cd FSdata

Task 1: create the script
=========================

1. Open a text editor and create the script runFreesurfer.sh

    .. code-block:: bash

        #!/bin/bash
        export SUBJECTS_DIR=$(pwd)
        recon-all -subjid FreeSurfer -i MP2RAGE.nii -all

2. Set the script to be executable

3. Submit the script to the cluster

    .. code-block:: bash

        $ echo "cd $PWD; ./runFreesurfer.sh" | qsub walltime=00:10:00,mem=1GB

4. Verify the job is running with ``qstat``. You should see something like:

    .. code-block:: bash

        $ qstat 11173851
        Job ID                    Name             User            Time Use S Queue
        +----------------------- ---------------- --------------- -------- - -----
        11173851.dccn-l029         STDIN            dansha                 0 Q long

5. Because we don't really want to run the analysis but rather test a script, kill the job with ``qdel``.  For example:

    .. code-block:: bash

        $ qdel 11173851
