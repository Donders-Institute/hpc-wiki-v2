.. _r-exercise-simple:

Exercise: distributed data analysis with R
******************************************

In this exercise, you will learn how to submit R jobs in the cluster using the ``Rscript``, the scripting front-end of R.

This exercise is divided into two tasks. The first task is to get you familiar with the flow of running R script as batch jobs in the HPC cluster. The second is more about bookkeeping outputs (R data files) produced by R jobs running concurrently in the cluster.

.. note::
    In this exercise, we will use commands in R and in Linux shell. When you see the commands started with a prompt ``$``, it means a command in Linux shell.  If you see ``>``, it implies a command to be typed in a R console.

Preparation
===========

Follow the steps below to download :download:`the prepared R scripts <R_exercise.tgz>`.

.. code-block:: bash

    $ mkdir R_exercise
    $ cd R_exercise
    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_R/r_exercise.tgz
    $ tar xvzf r_exercise.tgz
    $ ls
    magic_cal_2.R  magic_cal_3.R  magic_cal.R


Load environment for R version 4.1.0 (or any other version >= 4.1.0, this exercise has been tested to work on)

.. code-block:: bash

    $ module unload R
    $ module load R/4.1.0
    $ which R
    /opt/R/4.1.0/bin/R

Task 1: simple job
==================

In this task, we use the script ``magic_cal.R``. This script uses the ``magic`` library to generate a magic matrix of a given dimension, and calculate the sum of its diagonal elements.  The matrix and the sum are both printed to the standard output. Note, that it is not guaranteed that the ``magic`` library is available on the R-version that is used (and has been installed). The ``magic_cal.R`` script contains some lines at the top of the script that evaluates the availability of the library on the file system, and - if not available - installs the library in a temporary folder.

#. run the script interactively, for a matrix of dimension 5

   .. code-block:: bash

        $ Rscript magic_cal.R 5
        ...<some stuff depending on your R-install>...
        Loading required package: abind
             [,1] [,2] [,3] [,4] [,5]
        [1,]    9    2   25   18   11
        [2,]    3   21   19   12   10
        [3,]   22   20   13    6    4
        [4,]   16   14    7    5   23
        [5,]   15    8    1   24   17
        [1] 65

#. read and understand the ``magic_cal.R`` script

#. run the script to the cluster as a batch job

   .. code-block:: bash

        $ sbatch --time=00:10:00 --mem=256mb --job-name=magic_R << EOF
        #!/bin/bash
        Rscript magic_cal.R 5
        EOF

#. wait the job to finish, and check the output of the job. Do you get same results as running interactively?

#. run five batch jobs in parallel to run the ``magic_cal.R`` with matrices in dimension 5,6,7,8,9.

   .. code-block:: bash

        $ for d in {5..9}; do
        sbatch --time=00:10:00 --mem=256mb --job-name="magic_cal_$d" << EOF
        #!/bin/bash
        Rscript magic_cal.R $d
        EOF
        done

Task 2: job bookkeeping and saving output objects
=================================================

In the previous task, data objects are just printed to the standard output, which are consequently captured as text in the output files of the jobs.  Data stored in this way is hardly be reused for following analyses. A better approach is to store the objects in a R data file (i.e. the **RData** files), using the ``save`` function of R.

Given that batch jobs in the cluster will be executed at the same time, writing objects from different jobs into the same file is not recommended as the concurrency issue may result in corrupted outputs. A better approach is to write outputs of each job to a seperate file. In implies that running batch jobs in parallel requires an additional bookkeeping strategy on the jobs as well as the output files produced from them.

In this exercise, we are going to use the script ``magic_cal_2.R`` in which functions are provided to

* save objects into data file, and
* get job/process information that can be used for the bookkeeping purpose.

Follow the steps below:

#. run the script interactively

   .. code-block:: bash

        $ Rscript magic_cal_2.R 5
        WARNING: ignoring environment value of R_HOME
        Loading required package: abind
        saving objects  magic_matrix,sum_diagonal  to  magic_cal_2.out.RData  ...done

   From the terminal output, you see two objects are saved into a **RData** file called ``magic_cal_2.out.RData``.  Later on, you can load the object from this file into R or a R script.  For example,

   .. code-block:: r

        > load("magic_cal_2.out.RData")
        > ls()
        [1] "magic_matrix" "sum_diagonal"
        > magic_matrix
             [,1] [,2] [,3] [,4] [,5]
        [1,]    9    2   25   18   11
        [2,]    3   21   19   12   10
        [3,]   22   20   13    6    4
        [4,]   16   14    7    5   23
        [5,]   15    8    1   24   17
        > q(save="no")

#. read and understand the ``magic_cal_2.R`` script, especially the functions at the top of the script.

#. try to run ``magic_cal_2.R`` as batch jobs as we did in the previous task.

   .. tip::
        You probably noticed that the functions defined in ``magic_cal_2.R`` are so generic that they can be reused for different scripts.

        That is right!  In fact, we have factored out those functions into ``/opt/cluster/share/R`` so that you could easily make use of those functions in the future.

        In the script ``magic_cal_3.R``, it shows you how to load those functions in your R scripts.  It also shows you how to construct the name of the RData file using the job information.
