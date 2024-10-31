Exercise: simple batch job
**************************

The aim of this exercise is to get you familiar with the slurm client tools for submitting and managing cluster jobs. We will firstly create a script that calls the ``sleep`` command for a given period of time.  After that, we are going to submit the script as jobs to the cluster.

Tasks
=====

.. note::
    DO NOT just copy-n-paste the commands for the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

#. make a script called ``run_sleep.sh`` with the following content:

   .. code-block:: bash

        #!/bin/bash
        #SBATCH --job-name=sleep_1m
        #SBATCH --nodes=1
        #SBATCH --ntasks=1
        #SBATCH --time=00:01:30
        #SBATCH --mem=10MB

        my_host=$( /bin/hostname )

        time=$( date )
        echo "$time: $my_host falls asleep ..."

        sleep $1

        time=$( date )
        echo "$time: $my_host wakes up."
        
   .. note::
       Input argument of a bash script is accessible via variable ``$n`` where ``n`` is an integer referring to the n-th variable given the the script.  In the script above, the value ``$1`` on the line ``sleep $1`` refers to the first argument given the the script.  For instance, if you run the script as ``run_sleep.sh 10``, the value of ``$1`` is ``10``.

#. make sure the script runs locally

   .. code-block:: bash

        $ chmod +x run_sleep.sh
        $ ./run_sleep.sh 1
        Thu Oct 31 09:40:18 CET 2024: mentat006.dccn.nl falls asleep ...
        Thu Oct 31 09:40:19 CET 2024: mentat006.dccn.nl wakes up.


#. submit a job to run the script

   .. code-block:: bash

   $ sbatch $PWD/run_sleep.sh 60
   Submitted batch job 46288492

#. check the job status.  For example,

   .. code-block:: bash

        $ squeue --me
        JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
        46288492     batch run_slee   lenobl  R       0:27      1 dccn-c061

   .. note::
        The squeue command shows all interactive jobs and batch jobs currently running on the cluster. The '--me' flag alters the squeue command to only show the jobs that you submitted. 

#. or monitor it until it is complete

   .. code-block:: bash

        $ watch squeue --me

   .. tip::
        The ``watch`` command is used here to repeat the ``squeue`` command every 2 seconds. Press :kbd:`Control-c` to quit the ``watch`` program when the job is finished.

#. examine the output file, e.g. ``slurm-46288492.out``, and find out the resource consumption of this job. The job ID should be replaced accordingly.

   .. code-block:: bash

       $ grep -E 'Job ID|Job Exit Code|Username|Compute nodes|Asked resources|Used resources' slurm-46288492.out
        Username:        lenobl
        Asked resources: walltime=10:00,nodes=1,cpus=1,mem=1G
        Compute nodes:   dccn-c080
        Job ID:          46288492
        Job Exit Code:   0:0
        Username:        lenobl
        Compute nodes:   dccn-c080
        Asked resources: walltime=10:00,nodes=1,cpus=1,mem=1G
        Used resources:  cputime=00:01:00,walltime=00:01:00,memory=0

#. or retrieve information from the slurm job accounting database

.. code-block:: bash

        $ sacct -j 46288492 
        JobID           JobName  Partition    Account  AllocCPUS      State ExitCode 
        ------------ ---------- ---------- ---------- ---------- ---------- -------- 
        46288492     run_sleep+      batch       mhng          1  COMPLETED      0:0 
        46288492.ba+      batch                  mhng          1  COMPLETED      0:0 
        46288492.ex+     extern                  mhng          1  COMPLETED      0:0 

#. submit another job to run the script, with longer duration of ``sleep``.  For example,

   .. code-block:: bash

        $ sbatch $PWD/run_sleep.sh 3600
        Submitted batch job 46288593

   .. note::
        Try to compare the command in step 3 and the job parameters in the run_sleep.sh script.  As we expect the job to run longer, the requirement on the job walltime must be extend to 1 hour and 10 minutes within the script to account for this.

#. Ok, we don't want to wait for the 1-hour job to finish. Let's cancel the job.  For example,

   .. code-block:: bash

        $ scancel 46288593
