Exercise: distributed data analysis with MATLAB
***********************************************

In this exercise, you will learn how to submit MATLAB jobs in the cluster using two approaches that are commonly used at DCCN.

The first approach is to use a wrapper script called `matlab_sub`; while the second is to submit batch jobs right within the graphical interface of MATLAB.

.. note::
    In this exercise, we will use commands in MATLAB and in Linux shell. When you see the commands started with a prompt ``$``, it means a command in Linux shell.  If you see ``>>``, it implies a command to be typed in a MATLAB console.

Preparation
===========

Follow the steps below to download :download:`the prepared MATLAB scripts <matlab_exercise.tgz>`.

.. code-block:: bash

    $ wget http://dccn-hpc-wiki.rtfd.io/en/latest/_downloads/matlab_exercise.tgz
    $ tar xvzf matlab_exercise.tgz
    $ ls
    matlab_sub  qsub_toolbox

Task 1: matlab_sub
==================

When you have a MATLAB script file (i.e. the M-file) which **takes no input argument**, you can simply submit a job to run on the script using the ``matlab_sub`` command.

In this task, you are given a M-file which generates a 8x8 magic matrix, makes a sum of the diagonal elements, and finally saves the sum to a file. Follow the steps below for the exercise:

#. Switch the working directory in which the M-file is provided

   .. code-block:: bash

        $ cd matlab_sub
        $ ls
        magic_cal.m

#. Read and understand the ``magic_cal.m`` script

#. (Optional) Choose a desired MATLAB version, e.g. ``R2014b``

   .. code-block:: bash

        $ module unload matlab
        $ module load matlab/R2014b

   As long as you are fine with the default version of MATLAB, you can leave this step out.  The default version of MATLAB can be checked with:

   .. code-block:: bash

        $ module avail matlab

#. Submit a job to run the script

   .. code-block:: bash

        $ matlab_sub magic_cal.m

   You will be asked to provide the walltime and memory requirements of the job.
   
   .. tip::
       You can bypass the interaction of providing memory and walltime requirements by using the ``--mem`` and ``--walltime`` options of the ``matlab_sub`` script.
       
       The example below submits a job requesting resource of 4 GB memory and 1 hour walltime. 
       
       .. code-block:: bash
       
           $ matlab_sub --walltime 01:00:00 --mem 4gb magic_cal.m

#. Monitor the job until it is finished. You will see the output file ``magic_cal_output.mat`` containing the result.


Task 2: qsubcellfun
===================

#. Start matlab interactive session with the command

   .. code-block:: bash

        $ matlab2014a

#. In the matlab graphical interface, type the following commands to load the MATLAB functions for submitting jobs to the cluster.  Those functions are part of `the FieldTrip toolbox <http://www.fieldtriptoolbox.org/>`_.

   .. code-block:: matlab

        >> addpath '/home/common/matlab/fieldtrip/qsub'

#. Switch the working directory to which the prepared MATLAB functions are located. For example,

   .. code-block:: matlab

        >> cd qsub_toolbox
        >> ls
        qsubcellfun_demo.m  qsubfeval_demo.m  qsubget_demo.m  randn_aft_t.m

#. Open the file ``randn_aft_t.m``.  This matlab function keeps refreshing a n-dimentional array for a duration.  It takes two arguments: ``n`` for the array dimention, and ``t`` for duration. You could try to run it interactively using the MATLAB command below:

   .. code-block:: matlab

        >> n_array = {10,10,10,10,10};
        >> t_array = {30,30,30,30,30};
        >> out = cellfun(@randn_aft_t, n_array, t_array, 'UniformOutput', false);
        >> out

        out =

        Columns 1 through 4

            [10x10 double]    [10x10 double]    [10x10 double]    [10x10 double]

        Column 5

            [10x10 double]

#. The ``cellfun`` function above makes five iterations sequencially over the ``randn_aft_t`` function.  For every iteration, it fill in the function with ``n=10`` and ``t=30``.  Using the cluster, the iterations can be made in parallel via the `qsubcellfun` function. For example,

   .. code-block:: matlab

        >> out = qsubcellfun(@randn_aft_t, n_array, t_array, 'memreq', 10*10*8, 'timreq', 30, 'stack', 1);

   .. note::
        The ``qsubcellfun`` will block the MATLAB console until all submitted jobs are finished.

Task 3: qsubfeval
=================

An alternative way of running MATLAB functions in batch is to use the ``qsubfeval`` function.  In fact, ``qsubfeval`` is the underlying function called by the ``qsubcellfun`` for creating and submitting each individual job.

Following the steps below to run the same ``randn_aft_t`` function using ``qsubfeval``.

#. Start matlab interactive session with the command

   .. code-block:: bash

        $ matlab2014a

#. In MATLAB, load the ``qsub`` toolbox from `FieldTrip <http://www.fieldtriptoolbox.org>`_.

   .. code-block:: matlab

        >> addpath '/home/common/matlab/fieldtrip/qsub'

#. Switch the working directory to which the prepared MATLAB functions are located. For example,

   .. code-block:: matlab

        >> cd qsub_toolbox
        >> ls
        jobmon_demo.m  qsubcellfun_demo.m  qsubfeval_demo.m  qsubget_demo.m  randn_aft_t.m

#. Submit batch jobs to run on ``randn_aft_t`` function, using ``qsubfeval``.

   .. code-block:: matlab

        >> n_array = {2, 4, 6, 8, 10};
        >> t_array = {20, 40, 60, 80, 100};
        >> jobs = {};
        >>
        >> for i = 1:5
        req_mem   = n_array{i} * n_array{i} * 8;
        req_etime = t_array{i};
        jobs{i} = qsubfeval(@randn_aft_t,  n_array{i},  t_array{i},  'memreq',  req_mem,  'timreq',  req_etime);
        end
        >>
        >> save 'jobs.mat' jobs

   Each call of ``qsubfeval`` submits a job to run on a pair of ``n`` (array dimention) and ``t`` (duration). For this reason, we should make iteration ourselves using the ``for`` loop.  This is different to using the ``qsubcellfun``.

   Another difference is that the MATLAB prompt is not blocked after job submission. One benefit here is that we can continue with other MATLAB commands without the need to wait for jobs to finish. However, we need to save references to the submitted jobs in order to retrieve the results later.  In the example above, references of jobs are stored in the array of ``jobs``. You may also save to the reference to a file and leave MATLAB completely.

#. You probably noticed that the job reference returned from ``qsubfeval`` is not the torque job id. The ``qsublist`` function is provided to map the job reference to the torque job id. We could combine this function to query the job status, using a system call to the ``qstat`` command.  For example:

   .. code-block:: matlab

        >> load 'jobs.mat'
        >>
        >> for j = jobs
        jid = qsublist('getpbsid', j);
        cmd = sprintf('qstat %s', jid);
        unix(cmd);
        end

#. When all jobs are finished, one could retrive the output using ``qsubget``. For example,

   .. code-block:: matlab

        >> load 'jobs.mat'
        >>
        >> out = {};
        >>
        >> for j = jobs
        out = [out, qsubget(j{:})];
        end
        >>
        >> out
