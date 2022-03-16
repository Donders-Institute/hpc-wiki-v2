The analysis program is provided as a bash script named ``run_analysis.sh``.

Tasks
-----

#. before you start, go into the directory of the ``torque_exercise`` and run

    .. code-block:: bash

        $ ./clean.sh

    to remove previously produced results.

#. (optional) read the script ``run_analysis.sh`` and try to get an idea how to use it. Don't spend too much time in understanding every detail.

   .. tip::
        The script consists of a BASH **function** (``analyze_subject_data``) encapsulating the data-analysis algorithm. The function takes one input argument, the subject id. In the main program (the last line), the function is called with an input ``$1``. In BASH, variable ``$1`` is used to refer to the first argument of a shell command.

#. run the analysis interactively on the dataset of ``subject_0``

   .. code-block:: bash
   
       $ ./run_analysis.sh 0
      
   The command doesn't return any output to the terminal.  If it is successfully executed, you should see a photo in the folder ``subject_0``.
   
   .. tip::
        The script ``run_analysis.sh`` is writen to take one argument as the subject id.  Thus the command above will perform the data analysis algorithm on the dataset of ``subject_0`` interactively.

#. run the analysis by submitting 5 parallel jobs; each runs on a dataset.

   .. tip::
        The command ``seq 1 N`` is useful for generating a list of integers between ``1`` and ``N``. You could also use ``{1..N}`` as an alternative.

#. wait until the jobs finish and check out who our subjects are. You should see a file ``photo.*`` in each subject's folder.

Solution
--------

.. include:: bash_solution.rst
