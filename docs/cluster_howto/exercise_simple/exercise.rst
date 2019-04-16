Exercise: simple batch job
**************************

The aim of this exercise is to get you familiar with the torque client tools for submitting and managing cluster jobs. We will firstly create a script that calls the ``sleep`` command for a given period of time.  After that, we are going to submit the script as jobs to the cluster.

Tasks
=====

.. note::
    DO NOT just copy-n-paste the commands for the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

#. make a script called ``run_sleep.sh`` with the following content:

   .. code-block:: bash

        #!/bin/bash

        my_host=$( /bin/hostname )

        time=$( date )
        echo "$time: $my_host falls asleep ..."

        sleep $1

        time=$( date )
        echo "$time: $my_host wakes up."
        
   .. note::
       Input argument of a bash script is accessible via variable ``$n`` where ``n`` is a integer referring to the n-th variable given the the script.  In the script above, the value ``$1`` on the line ``sleep $1`` refers to the first argument given the the script.  For instance, if you run the script as ``run_sleep.sh 10``, the value of ``$1`` is ``10``.

#. make sure the script runs locally

   .. code-block:: bash

        $ chmod +x run_sleep.sh
        $ ./run_sleep.sh 1
        Mon Sep 28 16:36:28 CEST 2015: dccn-c007.dccn.nl falls asleep ...
        Mon Sep 28 16:36:29 CEST 2015: dccn-c007.dccn.nl wakes up.

#. submit a job to run the script

   .. code-block:: bash

        $ echo "$PWD/run_sleep.sh 60" | qsub -N 'sleep_1m' -l 'nodes=1:ppn=1,mem=10mb,walltime=00:01:30'
        6928945.dccn-l029.dccn.nl

#. check the job status.  For example,

   .. code-block:: bash

        $ qstat 6928945

   .. note::
        The torque job id given here should be replaced accordingly.

#. or monitor it until it is complete

   .. code-block:: bash

        $ watch qstat 6928945

   .. tip::
        The ``watch`` command is used here to repeat the ``qstat`` command every 2 seconds. Press :kbd:`Control-c` to quit the ``watch`` program when the job is finished.

#. examine the output file, e.g. ``sleep_10.o6928945``, and find out the resource consumption of this job

   .. code-block:: bash

        $ cat sleep_1m.o6928945 | grep 'Used resources'
        Used resources:	   cput=00:00:00,mem=4288kb,vmem=433992kb,walltime=00:01:00

#. submit another job to run the script, with longer duration of ``sleep``.  For example,

   .. code-block:: bash

        $ echo "$PWD/run_sleep.sh 3600" | qsub -N 'sleep_1h' -l 'nodes=1:ppn=1,mem=10mb,walltime=01:10:00'
        6928946.dccn-l029.dccn.nl

   .. note::
        Try to compare the command in step 3.  As we expect the job to run longer, the requirement on the job walltime is also extended to 1 hour 10 minutes.

#. Ok, we don't want to wait for the 1-hour job to finish. Let's cancel the job.  For example,

   .. code-block:: bash

        $ qdel 6928946
