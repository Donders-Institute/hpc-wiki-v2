Exercise: Running FreeSurfer jobs on the cluster
************************************************

In this exercise we will construct a small script to run FreeSurfer's ``recon-all``, and use ``sbatch`` to submit this script to the cluster for execution.

Preparation
===========

Move into the directory you'd like to work in and download :download:`the files prepared for the exercise <FSdata.tgz>` using this command:

.. code-block:: bash

    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_freesurfer/FSdata.tgz
    $ tar -xvf FSdata.tgz
    $ cd FSdata

Task 1: create the script
=========================

#. Open a text editor and create the script called ``runFreesurfer.sh``

   .. code-block:: bash

        #!/bin/bash
        export SUBJECTS_DIR=$(pwd)
        recon-all -subjid FreeSurfer -i MP2RAGE.nii -all

#. Set the script to be executable

#. Load the freesurfer module

   .. code-block:: bash
   
        $ module load freesurfer
        
   .. tip:
        You could try to load a different version of freesurfer, using the ``module`` command.

#. Submit the script to the cluster

   .. code-block:: bash

        $ sbatch --time=00:10:00 --mem=1gb $PWD/runFreesurfer.sh

#. Verify the job is running with ``qstat``. You should see something like:

   .. code-block:: bash

        $ squeue --me
          
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          46540218     batch runFrees   honlee  R       2:19      1 dccn-c065

#. Because we don't really want to run the analysis but rather test a script, kill the job with ``scancel``.  For example:

   .. code-block:: bash

        $ scancel 46540218
