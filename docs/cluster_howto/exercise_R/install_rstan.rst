.. _rstan-install:

Installation of brms/stan packages
===================================

This installation instruction shows you how to install brms/stan packages in R version 4.0.1.

Start R with needed dependencies
*********************************

Within a terminal in a VNC session, do

.. code-block:: bash

    $ module load R/4.0.1
    $ module load jdk

If you prefer using R in a text console, submit an interactive job with at-least 4GB memory, e.g.

.. code-block:: bash

    $ qsub -I -l walltime=1:00:00,mem=4gb

once the job is started, run ``R`` in the terminal.

If you prefer using rstudio, simply type ``rstudio`` in the terminal and use the dialog to set the job requirement, submit the job and wait for the rstudio window.

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