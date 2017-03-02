Exercise: finding resource requirement
**************************************

In this exercise, you will use two different ways to estimate the resource requirement of running a "fake" application.

We will focus on estimating the memory requirement, as it has significant impact on the resource utilisation efficiency of the cluster resources.

Preparation
===========

Download the :download:`"fake" applciation <fake_app>` which performs memory allocaiton and random number generation.  At the end of the computation, the fake application also produces the cube number of a given integer (i.e. ``n^3``).

Follow the commands below to download the fake application and run it locally:

.. code-block:: bash

    $ wget http://donders-institute.github.io/hpc-wiki/en/cluster_howto/exercise_resource/fake_app
    $ chmod +x fake_app
    $ ./fake_app 3 1

    compute for 1 seconds
    result: 27

The first argument (i.e. ``3``) is the base of the cube number.  The second argument (i.e. ``1``) specifies the duration of the computation in unit of second.

Although the result looks trivial, the program internally generates usage of CPU time and memory. The CPU time is clearly specified by the second input argument. The question here is the amount of memory needed for running this program.

Task 1: with the JOBinfo monitor
================================

In the first task, you will estimate the amount of memory required by the fake application, using a resource-utilisation monitor.

1. Start a VNC session (skip this step if you are already in a VNC session)

2. Submit an interactive job with the following command

    .. code-block:: bash

        $ qsub -I -l walltime=00:30:00,mem=1gb

    When the job starts, a small **JOBinfo** window pops up at the top-right corner.

3. Run the fake application under the shell prompt initiated by the interactive job

    .. code-block:: bash

        $ ./fake_app 3 60

    Keep your eyes on the **JOBinfo** window and see how the memory usage evolves. The **Max memory usage** indicates the amount of memory needed for the fake application.

4. Terminate the interactive job

Task 2: with job's STDOUT/ERR file
==================================

In this task, you will be confronted with an issue that the computer resource (in this case, the memory) allocated for your job is not sufficient to complete the computation. With few trials, you will find out a sufficient (but not overestimated) memory requirement to finish the job.

1. Download :download:`another fake application <fake_app_2>`

    .. code-block:: bash

        $ wget http://donders-institute.github.io/hpc-wiki/en/cluster_howto/exercise_resource/fake_app_2
        $ chmod +x fake_app_2

3. Try to submit a job to the cluster using the following command.

    .. code-block:: bash

        $ echo "$PWD/fake_app_2 3 300" | qsub -N fake_app_2 -M <your_email> -l walltime=600,mem=128mb

    .. warning::
        Remember to replace ``<your_email>`` with your actual email address.

2. Wait for the job to finish, and check the ``STDOUT`` and ``STDERR`` files of the job. Do you get the expected result in the ``STDOUT`` file?

3. Check your e-mail box for a notification about the job.  The content of it should looks similar to the following snippet.

    .. code-block:: bash
        :emphasize-lines: 6

        PBS Job Id: 10086535.dccn-l029.dccn.nl
        Job Name:   fake_app_2
        Exec host:  dccn-c365.dccn.nl/0
        job deleted
        Job deleted at request of root@dccn-l029.dccn.nl
        job 10086535 exceeded MEM usage hard limit (516 > 140)

4. Now check the job's ``STDOUT`` file again and find out the actual memory usage of the computation.

5. Try to submit the job again with the memory requirement increased sufficiently for the actual usage.

    .. tip::
        Specify the requirement higher, but as close as possible to the actual usage.

        Unnecessary high requirement results in inefficient usage of resources, and consequently blocks other jobs (including yours) from having sufficient resources to start.
