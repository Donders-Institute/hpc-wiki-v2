Distributed data analysis with Python
*************************************

.. note::
    If you are missing the context of this exercise, please refer to :ref:`exercise_da`.

.. include:: preparation.rst

Tasks
=====

#.  before you start, get into the directory of the ``torque_exercise`` and run

    .. code-block:: bash

        $ ./clean.sh

    to remove previously produced results.

#.  (optional) read the script ``run_analysis.py`` and try to get an idea how to use it. Don't spend too much time in understanding every detail.

    .. tip::
        The script consists of a Python function ``analyze_subject_data`` encapsulating the data-analysis algorithm. The function takes one input argument, the subject id.

#.  The ``run_analysis.py`` script makes use of a Python library called ``requests`` which needs to be installed.  We make use of Anaconda and conda environment to install the library in the home directory.

    Create a new conda environment with the commands below:

    .. code-block:: bash

        $ module load anaconda3
        $ conda create --name exercise
        ...
    
    Activating the conda environment, and install the library ``requests``:

    .. code-block:: bash

        $ source activate exercise

        [exercise] $ conda install requests
        ...

    .. tip::
        You will see the bash prompt is populated with the conda environment name.  It indicates that you are currently in the conda environment.  Only within the conda environment have you access to the ``requests`` library that we just installed.

#.  At this point, you can test run the ``run_analysis.py`` script with one subject.  Let's test the analysis on subject ``0`` by doing:

    .. code-block:: bash

        [exercise] $ ./run_analysis.py 0

    You should see the output file ``subject_0/photo.jpg`` when the analysis is done.

#.  Let's test again on another subject with a torque job

    In the command below, we just make an arbitrary (but sufficient) resource requirement of 10 minutes walltime and 1 GB memory.

    .. code-block:: bash

        [exercise] $ echo "$PWD/run_analysis.py 1" | qsub -l walltime=10:00,mem=1gb -N subject_1

    You should see the output file ``subject_1/photo.jpg`` when the analysis is done.  At this time, you also see the stdout/stderr files produced by the job.

#.  Run the clean up before we start the analysis in parallel.

    .. code-block:: bash

        [exercise] $ ./clean.sh

#.  In order to run the analysis on all the 6 subjects in parallel, we use a bash for loop:

    .. code-block:: bash

        [exercise] $ for id in {0..6}; do echo "$PWD/run_analysis.py $id" | qsub -l walltime=10:00,mem=1gb -N subject_$id; done