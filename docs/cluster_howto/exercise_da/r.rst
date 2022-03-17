Distributed data analysis with R
********************************

.. note::
    If you are missing the context of this exercise, please refer to :ref:`exercise_da`.

.. include:: preparation.rst

Tasks
=====

#.  before you start, get into the directory of the ``torque_exercise`` and run

    .. code-block:: bash

        $ ./clean.sh

    to remove previously produced results.

#.  (optional) read the script ``run_analysis.R`` and try to get an idea how to use it. Don't spend too much time in understanding every detail.

    .. tip::
        The script consists of a R function ``analyze_subject_data`` encapsulating the data-analysis algorithm. The function takes one input argument, the subject id.