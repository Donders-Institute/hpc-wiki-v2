Exercise: distribute data analysis in the Torque cluster
********************************************************

This exercise mimics a distributed data analysis assuming that we have to apply the same data analysis algorithm independently on the datasets collected from 6 subjects.  We will use the torque cluster to run the analysis in parallel.

Preparation
===========

Using the commands below to download :download:`the exercise package <torque_exercise.tgz>` and check its content.

.. code-block:: bash

    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_da/torque_exercise.tgz
    $ tar xvzf torque_exercise.tgz
    $ cd torque_exercise
    $ ls
    run_analysis.sh  subject_0  subject_1  subject_2  subject_3  subject_4  subject_5

In the package, there are folders for subject data (i.e. ``subject_{0..5}``).  In each subject folder, there is a data file containing an encrypted string (URL) pointing to the subject's photo.

In this fake analysis, we are going to find out who our subjects are, using an trivial "analysis algorithm" that does the following two steps in each subject folder:

1. decrypting the URL string, and
2. downloading the subject's photo.

The analysis algorithm has been provided as a function in the BASH script ``run_analysis.sh``.

Tasks
=====

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
========

.. include:: solution.rst
