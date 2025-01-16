.. _r-exercise-brms:

Exercise: distributed Bayesian regression modelling in R with `future` and `brms`
*********************************************************************************

In this exercise, you will learn how to run Bayesian regression with `brms` in parallel on the HPC. This tutorial assumes that you already know what `brms` is and just want to learn how to speed it up with the HPC capabilities. We will do it using `future` package (see more about `future` in :doc:`exercise_future`).

Preparation
===========

Follow the steps below to download :download:`the scripts for this tutorial <r_brms_exercise.tgz>` with Bash or just download the archive and unpack it in the directory of your choice on the cluster.

.. code-block:: bash

    $ mkdir R_exercise
    $ cd R_exercise
    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_R/r_brms_exercise.tgz
    $ tar xvzf r_brms_exercise.tgz
    $ ls
    batchtools.slurm.tmpl hpc_example_r_brms.R

Load RStudio. **Choose R version 4.3.3 and check "Load pre-installed R-packages" checkbox** as the packages needed are already included in the r-packages module on the HPC.

.. code-block:: bash

    rstudio

.. highlight:: r

Running `brms` on the cluster
=======================================

1. Load the necessary packages::

    library(brms)
    library(future)
    library(future.apply)

2. Load and set up the data::

    p <- read.csv("https://stats.idre.ucla.edu/stat/data/poisson_sim.csv") # load the data
    p <- within(p, { # set the important variables to factors
      prog <- factor(prog, levels=1:3, labels=c("General", "Academic",
                                                "Vocational"))
      id <- factor(id)
    })

3. Create a job plan for `future`. This job plan has two stages to make things more interesting for the demonstration purposes (it is also useful if you have a lot of different models to run)::

    plan(list(
      tweak(batchtools_slurm, resources = list(time = '00:20:00', mem = '6Gb', ncpus = 1, packages = c('brms'))), # first jobs are submitted for 20 minutes
      tweak(batchtools_slurm, resources = list(time = '00:05:00', mem = '6Gb', ncpus = 1, packages = c('brms')))  # the jobs created within these jobs are set to run with 5-minute limit
    ), .cleanup = T) # two-level parallelization setup to compile on the cluster and then run the chains in parallel

Note different resource requirements. We want more time for the first-level jobs so that it will be enough for setting up the model, waiting for the results, and combining the results.

4. Set a `brm` job::

    brm_job <- future({
        brm(num_awards ~ math + prog, data = p, family = 'poisson', future = T)
        })

The job is set within an expression (in {} curly brackets) as an argument for the `future` function. This is a first-level job. Then `brm` is called with an argument `future = T` so that the individual MCMC chains will also be send to the cluster as separate jobs.

5. You can wait for results as shown here or just do some other stuff while the job is running::

    while (!resolved(brm_job)) Sys.sleep(5) # wait until the job is finished

    brm_val <- value(brm_job) # load the results
    brm_val


