Exercise: interactive job
*************************

In this exercise, you will start an interactive job in the Torque cluster.  When the interactive job starts, check the hostname of the computer node on which your interactive job runs.

Tasks
=====

.. note::
    DO NOT just copy-n-paste the commands for the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

1. submit an interactive job with the following command and wait for the job to start.

    .. code-block:: bash

        $ qsub -I -N 'MyFirstJob' -l 'walltime=00:30:00,mem=128mb'

2. note the prologue message when the job starts.

3. check the hostname of the compute node with the command below:

    .. code-block:: bash

        $ hostname -f
        dccn-c012.dccn.nl

4. try few linux commands in this shell, e.g. ``ls``, ``cd``, etc.

    .. tip::
        In the interactive session, it is just like working in a Linux shell.

5. terminate the job by the ``exit`` command

    .. code-block:: bash

        $ exit

    After that, you should get back to the Linux shell on the access node where your job was submitted.
