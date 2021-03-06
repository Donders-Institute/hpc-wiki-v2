Exercise: finding resource requirement
**************************************

In this exercise, you will use two different ways to estimate the resource requirement of running a "fake" application.

We will focus on estimating the memory requirement, as it has significant impact on the resource utilisation efficiency of the cluster resources.

Preparation
===========

Download the :download:`"fake" applciation <fake_app>` which performs memory allocaiton and random number generation.  At the end of the computation, the fake application also produces the cube number of a given integer (i.e. ``n^3``).

Follow the commands below to download the fake application and run it locally:

.. code-block:: bash

    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_resource/fake_app
    $ chmod +x fake_app
    $ ./fake_app 3 1

    compute for 1 seconds
    result: 27

The first argument (i.e. ``3``) is the base of the cube number.  The second argument (i.e. ``1``) specifies the duration of the computation in unit of second.

Although the result looks trivial, the program internally generates usage of CPU time and memory. The CPU time is clearly specified by the second input argument. The question here is the amount of memory needed for running this program.

Task 1: with the JOBinfo monitor
================================

In the first task, you will estimate the amount of memory required by the fake application, using a resource-utilisation monitor.

#. Start a VNC session (skip this step if you are already in a VNC session)

#. Submit an interactive job with the following command

   .. code-block:: bash

        $ qsub -I -l walltime=00:30:00,mem=1gb

   When the job starts, a small **JOBinfo** window pops up at the top-right corner.

#. Run the fake application under the shell prompt initiated by the interactive job

   .. code-block:: bash

        $ ./fake_app 3 60

   Keep your eyes on the **JOBinfo** window and see how the memory usage evolves. The **Max memory usage** indicates the amount of memory needed for the fake application.

#. Terminate the interactive job

Task 2: with job's STDOUT/ERR file
==================================

In this task, you will be confronted with an issue that the computer resource (in this case, the memory) allocated for your job is not sufficient to complete the computation. With few trials, you will find out a sufficient (but not overestimated) memory requirement to finish the job.

#. Download :download:`another fake application <fake_app_2>`

   .. code-block:: bash

        $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_resource/fake_app_2
        $ chmod +x fake_app_2

#. Try to submit a job to the cluster using the following command.

   .. code-block:: bash

        $ echo "$PWD/fake_app_2 3 300" | qsub -N fake_app_2 -l walltime=600,mem=128mb

#. Wait for the job to finish, and check the ``STDOUT`` and ``STDERR`` files of the job. Do you get the expected result in the ``STDOUT`` file?

#. In the ``STDOUT`` file, find out relative information concerning job running out of memory limitation in the *Epilogue* section.  In the example below, the information are presented on lines 4,9 and 10.

   On line 4, it shows that the job's exit code is 137.  This is the first hint that the job might be killed by the system kernel due to memory over usage.  On line 9, you see the memory requirement specified at the job submission time; while on line 10, it shows that the maximum memory used by the job is 134217728 bytes, which is very close to the 128mb in the requirement (i.e. the "asked resources").

   Putting these information together, what happend behind the scene was that the job got killed by the kernel when the computational process (the ``fake_app_2`` in this case) tried to allocate memory more than what was requested for the job.  The killing caused the process to return an exit code 9; and the Torque scheduler translated it to the job's exit code by adding an extra 128 to the process' exit code.

   .. code-block:: bash
        :linenos:
        :emphasize-lines: 4,9,10

        ----------------------------------------
        Begin PBS Epilogue Wed Oct 17 10:18:53 CEST 2018 1539764333
        Job ID:		   17635280.dccn-l029.dccn.nl
        Job Exit Code:     137
        Username:	   honlee
        Group:		   tg
        Job Name:	   fake_app_2
        Session:	   15668
        Asked resources:   walltime=00:10:00,mem=128mb
        Used resources:	   cput=00:00:04,walltime=00:00:19,mem=134217728b
        Queue:		   veryshort
        Nodes:		   dccn-c365.dccn.nl
        End PBS Epilogue Wed Oct 17 10:18:53 CEST 2018 1539764333
        ----------------------------------------


#. Try to submit the job again with the memory requirement increased sufficiently for the actual usage.

   .. tip::
        Specify the requirement higher, but as close as possible to the actual usage.

        Unnecessary high requirement results in inefficient usage of resources, and consequently blocks other jobs (including yours) from having sufficient resources to start.
