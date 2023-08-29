.. _run-computations-slurm:

Running computations on the Slurm cluster
*****************************************

.. warning::
    The DCCN slurm cluster is still in the preview/testing phase.  **DO NOT** rely on it for producing your data analysis results.

What is the Slurm cluster?
==========================

Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters. More about Slurm on `the official site <https://slurm.schedmd.com/overview.html>`_.

Migrating from Torque/PBS to SLURM
==================================

+------------------------------+----------------------------------+------------------------------------------+
| Task                         | Torque/PBS                       | SLURM                                    |
+==============================+==================================+==========================================+
| Submit a job                 | qsub myjob.sh                    | sbatch myjob.sh                          |
+------------------------------+----------------------------------+------------------------------------------+
| Delete a job                 | qdel 123                         | scancel 123                              |
+------------------------------+----------------------------------+------------------------------------------+
| Show job status              | qstat                            | squeue                                   |
+------------------------------+----------------------------------+------------------------------------------+
| Show expected job start time | \- (showstart in Maui/Moab)      | squeue --start                           |
+------------------------------+----------------------------------+------------------------------------------+
| Show queue info              | qstat -q                         | sinfo                                    |
+------------------------------+----------------------------------+------------------------------------------+
| Show job details             | qstat -f 123                     | scontrol show job 123                    |
+------------------------------+----------------------------------+------------------------------------------+
| Show queue details           | qstat -Q -f <queue>              | scontrol show partition <partition_name> |
+------------------------------+----------------------------------+------------------------------------------+
| Show node details            | pbsnode n0000                    | scontrol show node n0000                 |
+------------------------------+----------------------------------+------------------------------------------+
| Show QoS details             | \- (mdiag -q <QoS> in Maui/Moab) | sacctmgr show qos <QoS>                  |
+------------------------------+----------------------------------+------------------------------------------+

Resource sharing and job prioritisation
=======================================

For optimising the utilisation of the computing resources, certain resource-sharing and job prioritisation policies are applied to jobs submitted to the Slurm cluster.  The implications to users can be seen from the the three aspects: **partition**, **throttling policies for resource usage** and **job prioritisation**.

Partition
---------

In the Slurm cluster, compute nodes are divided in partitions.

+------------+-----------------------+---------------------+--------------+
| partition  | max. walltime per job | max. memory per job | job priority |
+============+=======================+=====================+==============+
| batch      | 72 hours              | 256 GB              | normal       |
+------------+-----------------------+---------------------+--------------+
| interactive| 72 hours              | 64 GB               | high         |
+------------+-----------------------+---------------------+--------------+

Throttling policies for resource usage
---------------------------------------

In the Slurm cluster at DCCN, throttle policies are applied to limit the amount of resources an user can allocate at the same time.  It is to avoid resources of the entire cluster being occupied by a single user.  The policies are defined per partition:

+------------+---------------+-----------------+--------+-----------+
| partition  | runnable jobs | queue-able jobs | memory | cpu cores |
+============+===============+=================+========+===========+
| batch      | 10            | 100             | 512 GB | 64        |
+------------+---------------+-----------------+--------+-----------+
| interactive| 2             | 4               | 256 GB | 32        |
+------------+---------------+-----------------+--------+-----------+

Job prioritisation
------------------

Job priority determines the order of waiting jobs to start in the cluster. Job priority is calculated based on various factors.  In the cluster at DCCN, mainly the following two factors are considered.

#. **The waiting time a job has spent in the queue**: this factor will add one additional priority point to jobs waiting for one additional minute in the queue.

#. **Partition priority**: this factor is mainly used for boosting *interactive* jobs (i.e. jobs submitted to the interactive partition) with an outstanding priority offset so that they will be started sooner than other types of jobs.

The final job priority combining the two factors is used by the scheduler to order the waiting jobs accordingly. The first job on the ordered list is the next to start in the cluster.

Note: Job priority calculation is dynamic and not complete transparent to users.  One should keep in mind that the cluster does not treat the jobs as "first-come first-serve".

The `slurm` module
==================

Wrapper scripts, such as ``vncmanager``, ``matlab``, ``rstudio``, ``pycharm``, etc. are available via environment module ``slurm``.

.. code-block:: bash

    $ module load slurm

Interactive job
===============

Hereafter is an example command to start an interactive job with requirement of 1 hour walltime and 1 GB memory:

.. code-block:: bash

    $ srun --time=01:00:00 --mem=1gb -p interactive --pty bash -i

The terminal will be blocked until the job starts on the compute node.

Alternatively, one can also use the wrapper script ``sbash`` to start an interactive job.

Batch job
=========

#. prepare a batch job script like one below and save it to a file, e.g. ``slurm_first_job.sh``:

    .. code-block:: bash

        #!/bin/bash
        #SBATCH --job-name=myfirstjob
        #SBATCH --nodes=1
        #SBATCH --time=0-00:05:00
        #SBATCH --mail-type=FAIL
        #SBATCH --partition=batch
        #SBATCH --mem=5GB

        hostname

        echo "Hello from job: ${SLURM_JOB_NAME} (id: ${SLURM_JOB_ID})"

        sleep 600

    The script is essentially a bash script with few comment lines right after the script's shebang (i.e. the first line).  Those comment lines are started with ``#SBATCH`` followed by options the same as the options supported by Slurm's job submission program ``sbatch``. 

#. submit the job script to slurm

    .. code-block:: bash

        $ sbatch slurm_first_job.sh
        Submitted batch job 951

A job id is returned after job submission. In the example above, the job id is ``951``.

Job status and information
==========================

One can use the ``squeue`` to get an overview of running and pending jobs.

.. code-block:: bash

    $ squeue
        JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
        951   batch     myfirstj   honlee  R       0:05      1 dccn-c079

To get job's detail information, one use the command ``scontrol``:

.. code-block:: bash

    $ scontrol show job 951
    JobId=951 JobName=myfirstjob
    UserId=honlee(10343) GroupId=tg(601) MCS_label=N/A
    Priority=829 Nice=0 Account=tg QOS=normal
    JobState=RUNNING Reason=None Dependency=(null)
    Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
    RunTime=00:03:16 TimeLimit=00:05:00 TimeMin=N/A
    SubmitTime=2023-08-24T16:19:17 EligibleTime=2023-08-24T16:19:17
    AccrueTime=2023-08-24T16:19:17
    ...

.. note::
    ``squeue`` and ``scontrol`` can only be used to display status/information of ``running`` and ``pending`` jobs.  Use the command ``sacct`` to get information about historical job.

Once the job is completed, one should use the ``sacct`` command to get the information:

.. code-block:: bash

    $ sacct -j 951
    JobID           JobName  Partition    Account  AllocCPUS      State ExitCode
    ------------ ---------- ---------- ---------- ---------- ---------- --------
    951          myfirstjob      batch         tg          1    TIMEOUT      0:0
    951.batch         batch                    tg          1  CANCELLED     0:15
    951.extern       extern                    tg          1  COMPLETED      0:0

``sacct`` has an option ``--json`` to dump the output in JSON format.  It can be used together with `jq <https://jqlang.github.io/jq/>`_ for further processing on the job information. For example, to get on which nodes resources were allocated for the job: 

.. code-block:: bash

    $ sacct --json -j 951 | jq -r '.jobs[] | .nodes'
    dccn-c079

Job deletion
============

To delete a running or pending job, one use the ``scancel`` command:

.. code-block:: bash

    $ scancel 951

.. _slurm-job-output-stream:

Output streams of the job
=========================

On the compute node, the job itself is executed as a process in the system.  The default ``STDOUT`` and ``STDERR`` streams of the process are both redirected to a file named as ``slurm-<job_id>.out`` within the directory from which a job is submitted.  The file is available from the start of the job.

Specifying resource requirement
===============================

Each job submitted to the cluster comes with a resource requirement. The job scheduler and resource manager of the cluster make sure that the needed resources are allocated for the job. To allow the job to complete successfully, it is important that a right and sufficient amount of resources are specified at the job submission time.

1 CPU core, 4 gigabytes memory and 12 hours wallclock time
----------------------------------------------------------

.. code-block:: bash

    $ sbatch -N 1 -c 1 --ntasks-per-node=1 --mem=4G --time=12:00:00 job.sh

4 CPU cores on a single node, 12 hours wallclock time, and 4 gb memory
----------------------------------------------------------------------

.. code-block:: bash

    $ sbatch -N 1 -c 4 --ntasks-per-node=1 --mem=4G --time=12:00:00 job.sh

1 CPU core, 500gb of free local "scratch" diskspace, 12 hours wallclock time, and 4 gb memory
---------------------------------------------------------------------------------------------

.. code-block:: bash

    $ sbatch -N 1 -c 1 --ntasks-per-node=1 --mem=4G --time=12:00:00 --tmp=500G job.sh

1 **Intel** CPU core, 4 gigabytes memory and 12 hours wallclock time
--------------------------------------------------------------------

.. code-block:: bash

    $ sbatch -N 1 -c 1 --ntasks-per-node=1 --mem=4G --time=12:00:00 --tmp=500G --gres=cpu:intel job.sh

Here we ask the allocated CPU core to be on a node with GRES ``cpu:intel``.

4 CPU cores distributed on 2 nodes, 12 hours wallclock time, and 4 gb memory per node.
--------------------------------------------------------------------------------------

.. code-block:: bash

    $ sbatch -N 2 -n 4 --mem=4G --time=12:00:00 job.sh

Here we use ``-n`` to specify the amount of CPU cores we need; and ``-N`` to specify from how many compute nodes the CPU cores should be allocated.  In this scenario, the job (or the application the job runs) should take care of the communication between the processors distributed on many nodes.  This is typically for the `MPI <https://en.wikipedia.org/wiki/Message_Passing_Interface>`_-like applications.

1 GPU with minimal `cuda capability <https://developer.nvidia.com/cuda-gpus>`_ 5.0, 12 hours wallclock time, and 4 gb memory
----------------------------------------------------------------------------------------------------------------------------

*TBD*

Estimating resource requirement
===============================

As we have mentioned, every job has attributes specifying the required resources for its computation. Based on those attributes, the job scheduler allocates resources for jobs. The more precise these requirement attributes are given, the more efficient the resources are used. Therefore, we encourage all users to estimate the resource requirements before submitting massive jobs to the cluster.

The **walltime** and **memory** requirements are the most essential ones amongst others. Hereafter are three different ways to make estimations of those two requirements.

.. note::
    Computing resources in the cluster are reserved for jobs in terms of size (e.g. amount of requested memory and CPU cores) and duration (e.g. the requested walltime). Under-estimating the requirement causes job to be killed before completion and thus the resources have been consumed by the job were wasted; while over-estimating blocks resources from being used efficiently.

#. Consult your colleages

   If your analysis tool (or script) is commonly used in your research field, consulting with your colleagues might be just an efficient way to get a general idea about the resource requirement of the tool.

#. Monitor the resource consumption (with an interactive test job)

   A good way of estimating the wall time and memory requirement is through monitoring the usage of them at run time. This approach is only feasible if you run the job interactively through a graphical interface. Nevertheless, it's encouraged to test your data analysis computation interactively once before submitting it to the cluster with a large amount of batch jobs. Through the interactive test, one could easily debug issues and measure the resource usage.

   Upon the start of an interactive job, a resource consumption monitor is shown on the top-right corner of your VNC desktop.  An example is shown in the following screenshot:

   .. figure:: figures/slurm_interactive_jobinfo.png
      :figwidth: 80%
      :align: center

   The resource monitor consists of three bars.  From top to bottom, they are:

   * Elapsed walltime: the bar indicates the elapsed walltime consumed by the job.  It also shows the remaining walltime.  The walltime is adjusted accordingly to the CPU speed.
   * Memory usage: the bar indicates the current memory usage of the job.
   * Max memory usage: the bar indicates the peak memory usage of the job.

#. Check the epilogue information at the end of the job output stream

    For batch jobs, the epilogue script also writes the accounting information to :ref:`the job's output stream <slurm-job-output-stream>`.  One could also take it as a reference to determine the amount of resources needed for the computation. 
