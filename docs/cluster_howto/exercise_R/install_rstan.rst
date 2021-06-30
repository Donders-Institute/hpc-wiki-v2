.. _rstan-install:

Installation of brms/stan packages
===================================

This installation instruction shows you how to install brms/stan packages in R version 4.0.1.

Start R with required dependencies
***********************************

Within a terminal in a VNC session, do

.. code-block:: bash

    $ module load R/4.0.1
    $ module load jdk

Check if the ``gcc`` compiler is pointed to ``/opt/gcc/7.2.0/bin/gcc``:

.. code-block:: bash

    $ which gcc
    /opt/gcc/7.2.0/bin/gcc

If you prefer using R in a text console, submit an interactive job with more than 4GB memory, e.g.

.. code-block:: bash

    $ qsub -I -l walltime=1:00:00,mem=4gb

once the job is started, run ``R`` in the terminal.

If you prefer using rstudio, simply type ``rstudio`` in the terminal and use the dialog to set the job requirement, submit the job and wait for the rstudio window to pop up.

Install rstan/brms
*******************

Once you are in a R session (either in the console or in rstudio), run the following three R commands to install rstan/brms and their dependencies:

.. code-block:: r

    > install.packages("V8", dependencies = TRUE)
    > install.packages("rstan", dependencies = TRUE)
    > install.packages("brms", dependencies = TRUE)
    
Test installation
*****************

With a successful installation, you should be able to load the rstan package by running

.. code-block:: r

    > library(rstan)

It is recommended that you also test with the simple *Eight Schools* example from the rstan wiki. You could follow the instruction on this `link <https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started#example-1-eight-schools>`_, or use the simplified instruction below:

#. In a VNC session, open a terminal and run the commands below to download the R script and data:

    .. code-block:: bash

        $ cd
        $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_R/rstan_eightschools.tgz
        $ tar xvzf rstan_eightschools.tgz
        $ ls rstan_workspace
        rstan_test_eightschools.R  schools.stan

#. Run ``rstudio`` in the terminal with more than 4 GB memory; wait for the rstudio to start.

#. Within the rstudio, open the R script ``~/rstan_workspace/rstan_test_eightschools.R`` and run it interactively.  You sould see the resulting plot in the *plots* panel of rstudio, like the one below:

    .. figure:: ../figures/rstudio_rstan_eightschools_plot.png
        :figwidth: 75%