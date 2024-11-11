Distributed data analysis with Matlab
*************************************

.. note::
    If you are missing the context of this exercise, please refer to :ref:`exercise_da`.

.. include:: preparation.rst

Before you start, get into the directory of the ``hpc_exercise_slurm`` and run

.. code-block:: bash

    $ ./clean.sh

to remove previously produced results.

Optionally, read the Matlab program ``run_analysis.m`` and try to get an idea how to use it. Don't spend too much time in understanding every detail.

.. tip::
    The script consists of a Matlab function ``run_analysis`` encapsulating the data-analysis algorithm. The function takes one input argument, the subject id.

Task 1: Using ``matlab_sub`` 
============================

#.  check the Matlab wrapper script ``run_subject_0.m``.

    .. note::
        Since the ``matlab_sub`` command doesn't take any input argument, we cannot submit the ``run_analysis.m`` directly with ``matlab_sub``.
        
        A workaround is to provide another script in which the function defined in ``run_analysis.m`` is called with a hard-coded argument; therefore the ``run_subject_0.m`` script.
    
#.  submit a job via ``matlab_sub`` to run the ``run_subject_0.m`` with Matlab.

    .. code-block:: bash

        $ matlab_sub ./run_subject_0.m

    and follow the instructions in the terminal to provide required walltime and memory.  At the end, a job will be submitted.

    Wait for the job to finish, and check if you get the output photo in the ``subject_0`` directory.

    .. code-block:: bash

        $ ls -l subject_0/photo.jpg

#.  clean the data

    .. code-block:: bash

        $ ./clean.sh

Task 2: Using ``qsubcellfun``
=============================

#.  In your VNC session, start the Matlab desktop GUI like the commands below:

    .. code-block:: bash

        $ cd ~/hpc_exercis_slurm
        $ matlab

    In the popup dialog, you could specify the amount of resources you need.  In this exercise, we simply click through it.  It will submit an interactive job to run the Matlab desktop on a compute node.  Wait for the Matlab desktop to show up in your VNC session.

    .. note::
        From this point on, we will work within the Matlab desktop GUI.  All commands in the following steps should be done within the command window of Matlab.

#.  Change the current workding directory to the ``hpc_exercis_slurm`` directory in the command window:

    .. code-block:: matlab

        >> cd ~/hpc_exercis_slurm
        >> ls
        clean.sh  run_analysis.m  subject_0	subject_1  subject_2  subject_3  subject_4  subject_5 ...

#.  Load the qsub toolbox of fieldtrip

    .. code-block:: matlab

        >> addpath '/home/common/matlab/fieldtrip/qsub'

#.  Test run over the 6 subjects sequentically with the Matlab's ``cellfun`` function

    .. code-block:: matlab

        >> out = {}
        >> ids = num2cell(0:5)
        >> out = cellfun(@run_analysis, ids, 'UniformOutput', false)

    .. note::
        Since the the ``run_analysis`` function returns the path of the subject's photo, the variable ``out`` will be an array of 6 paths, each for a subject's photo.

    After the prompt is returned successfully, you should see the photos of all 6 subjects.  Let's list all of them based on the returned ``out`` 

    .. code-block:: matlab

        >> for o = out
        system(sprintf("ls -l %s", o{1}));
        end

    Clean up the output

    .. code-block:: matlab

        >> system('./clean.sh')

#.  Run over the 6 subjects in parallel with the ``qsubcellfun`` function

    .. code-block:: matlab

        >> out = {}
        >> ids = num2cell(0:5)
        >> out = qsubcellfun(@run_analysis, ids, 'memreq', 1024^3, 'timreq', 300, 'stack', 1)

    In this case, 6 jobs are submitted, each runs the analysis on a subject. The resource requirements of each job are 300 secs walltime and 1 GB memory.

    The prompt will return only if all jobs are all finished.
    
    List the output files based on the returned ``out`` variable:

    .. code-block:: matlab

        >> for o = out
        system(sprintf("ls -l %s", o{1}));
        end

    Clean up the output:

    .. code-block:: matlab

        >> system('./clean.sh')    

Task 3: Using ``qsubfeval`` and ``qsubget``
===========================================

Instead of using ``qsubcellfun`` shown in Task 1.  We could also use the combination of ``qsubfeval`` and ``qsubget``.  This approach puts submitted jobs in the background without blocking the command window.

#.  Make sure you are in the right working directory, and having the qsubtoolbox loaded in Matlab:

    .. code-block:: matlab
    
        >> cd ~/hpc_exercis_slurm
        >> addpath '/home/common/matlab/fieldtrip/qsub/'

#.  Submit jobs to run the 6 subjects in parallel using ``qsubfeval``

    .. code-block:: matlab

        >> jobs = {};
        >> for id = 0:5
        jobs{id+1} = qsubfeval(@run_analysis, id,  'memreq',  1024^3,  'timreq',  300);
        end

        >> % save recorded job identifiers to file %
        >> save 'jobs.mat' jobs

#.  Check job status

    .. code-block:: matlab

        >> % load job identifiers from file %
        >> load 'jobs.mat'
        >> for j = jobs
        jid = qsublist('getpbsid', j);
        system(sprintf('scontrol show job %s', jid));
        end

    .. tip::
        The idea of the for loop above is to find the Slurm job id from the job identifier returned from ``qsubfeval`` using the ``qsublist`` function.  With the Slurm job id, the job detail is retrieved by making a ``scontrol show job`` system call.

        Since checking over jobs is a regular task, there is a small function called ``check_jobs.m`` in the exercise package.  Instead of typing the foor-loop everytime, you could also call:

        .. code-block:: matlab

            >> check_jobs(jobs);

    Repeat the for-loop of checking job status until all jobs are reported completed (i.e. in status ``C``).

#.  Check job output using ``qsubget``

    .. code-block:: matlab

        >> out = {};
        >> for j = jobs
        out = [out, qsubget(j{:})];
        end

        >> out

    Now we have extracted the ``out`` from the submitted jobs.  Let's list the output files based on it to see if we get the subject's photos:

    .. code-block:: matlab

        >> for o = out
        system(sprintf("ls -l %s", o{1}));
        end

    Clean up the output

    .. code-block:: matlab

        >> system('./clean.sh')
