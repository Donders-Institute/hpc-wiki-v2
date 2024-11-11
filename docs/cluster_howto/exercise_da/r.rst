Distributed data analysis with R
********************************

.. note::
    If you are missing the context of this exercise, please refer to :ref:`exercise_da`.

.. include:: preparation.rst

Tasks
=====

#.  before you start, get into the directory of the ``hpc_exercis_slurm`` and run

    .. code-block:: bash

        $ ./clean.sh

    to remove previously produced results.

#.  (optional) read the script ``run_analysis.R`` and try to get an idea how to use it. Don't spend too much time in understanding every detail.

    .. tip::
        The script consists of a R function ``analyze_subject_data`` encapsulating the data-analysis algorithm. The function takes one input argument, the subject id.

#.  make a test run of ``run_analysis.R`` on subject ``0``

    .. code-block:: bash

        $ module load R
        $ Rscript ./run_analysis.R 0

    On success, you should see the output file being created in the ``subject_0`` directory.

    .. code-block:: bash

        $ ls -l subject_0/photo.jpg

    Run the clean script to remove the output of the test.

    .. code-block:: bash

        $ ./clean.sh

#.  Let's test again on anoter subject (i.e. subject 3) with a slurm job.

    .. code-block:: bash

        $ sbatch --job-name=subject_3 --time=10:00 --mem=1gb --wrap="Rscript $PWD/run_analysis.R 3"

    .. note::
        Note that we use the ``--wrap`` option of the ``sbatch`` command here.  It is needed becasue the executable ``Rscript`` is not really a (Bash or Python) script.

    Wait until the job to finish, and check if you get the output in ``subject_3`` directory.

    .. code-block:: bash

        $ ls -l subject_3/photo.png

    Run the clean script again before we perform the analysis on all subjects:

    .. code-block:: bash

        $ ./clean.sh

#.  Run the analysis on all subjects in parallel

    .. code-block:: bash

        $ for id in {0..5}; do sbatch --job-name=subject_$id --time=10:00 --mem=1gb --wrap="Rscript $PWD/run_analysis.R $id"; done

    and check if you get outputs (photos) of all 6 subjects.
