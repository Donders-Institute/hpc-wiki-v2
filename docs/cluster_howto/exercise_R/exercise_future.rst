.. _r-exercise-future:

Exercise: distributed data analysis in R with `future` and `batchtools`
***********************************************************************

.. warning::
     This page requires an update for the Slurm cluster.

In this exercise, you will learn how to submit R jobs in the cluster using the ``future`` and ``batchtools`` packages in R . This approach is different from vanilla Rscript approach shown in the :doc:`exercise` where you write an R script and submit it to the HPC with Bash. Here, you would submit the code to the cluster from within R through ``future``, using additional power provided by ``batchtools`` to parallelize your code and keep track of the running jobs. For this tutorial, we will use RStudio to run and edit the code.

Preparation
===========

Follow the steps below to download :download:`the scripts for this exercise <r_future_exercise.tgz>` with Bash or just download the archive and unpack it in the directory of your choice on the cluster.

.. code-block:: bash

    $ mkdir R_exercise
    $ cd R_exercise
    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/cluster_howto/exercise_R/r_future_exercise.tgz
    $ tar xvzf r_future_exercise.tgz
    $ ls
    batchtools.torque.tmpl hpc_example_r_batchtools_future.R

Load RStudio. **Choose R version 4.1.0 and check "Load pre-installed R-packages" checkbox** as the packages needed are already included in the r-packages module on the HPC.

.. code-block:: bash

    rstudio

.. highlight:: r

Task 1: simple jobs with future
========================================

In this task, we send jobs to the cluster using ``future`` and ``future.apply`` packages.

First, load the packages::

        library(future)
        library(future.apply)
        library(future.batchtools)

These three packages do different things. ``future`` provides the basic framework for asynchronous evaluation of expressions (meaning that you can run several things in parallel). ``future.apply`` provides the functionality analogous to \*apply functions in base R. Finally, ``future.batchtools`` allows to use HPC clusters with ``future``.

Then, indicate that you want to use our HPC (which uses PBS Torque to distribute jobs) by selecting the right job plan::

        plan(batchtools_torque, resources = list(walltime = '00:05:00', memory = '2Gb'))

Note that you can also specify the resources you need like shown here. For this code to work, ``batchtools.torque.tmpl`` should be in the current working directory. ``future`` works with many different backends, so you can use ``plan(multiprocess)`` to run the code on different CPU cores on your desktop machine, for example.

.. note::
    You can also rename the template to ``.batchtools.torque.tmpl`` with a dot at the beginning and put it in a home directory at the cluster, then you can use it in all scripts.

For this exercise, we will use a simple function that compute the mean of a random normal sample of 100 numbers with the true mean given as the function parameter::

    get_random_mean <- function(mu){
      mean(rnorm(100, mu))
    }

To submit a job you can use the ``%<-%`` operator::

    single_result %<-% get_random_mean(50) # submit a single job

That's it, the job is now sent to cluster. To check if it is completed, you can use ``resolved``::

    resolved(single_result) # check if it is completed
    single_result # wait until the job is finished and print the result

What if you want to submit more than one job? You can sent multiple jobs using functions from ``future.apply`` package that are analogous to \*apply functions from base R. For example, we can compute the sample mean for different parameters in base R via ``sapply``::

    sapply(40:60, get_random_mean)

To do the same on the cluster, you could use ``future_sapply``::

    res <- future_sapply(40:60, get_random_mean)
    resolve(res) # wait for the results

Task 2: using batchtools for better jobs management
==================================================================

``future`` is a very nice tool, but it lacks capabilities for job management. Imagine that you want to run 50k simulations. You can do it through ``future_sapply``, but it is not very convenient. For example, the results are difficult to recover if R would crash mid-way. This and many other problems are solved by using ``batchtools``.

``batchtools`` operates through *registries*. A register keeps all the details about your jobs.  To create a registry use ``makeRegistry`` function::

    library(batchtools)
    reg = makeRegistry(file.dir = '.batch_registry', seed = 1)

This creates a folder ``.batch_registry`` where all the information about your jobs will be saved. Then you need to specify the backend to be used::

    reg$cluster.functions = makeClusterFunctionsTORQUE()

Again, this function looks for ``batchtools.torque.tmpl`` in the working directory or for ``.batchtools.torque.tmpl`` in the home directory.

As an example, we will again generate random numbers but this time we will set the population mean and standard deviation as function parameters and return both the sample mean and the sample standard deviation::

    get_random_mean2 <- function(mu, sigma, ...){
        x <- rnorm(100, mean = mu, sd = sigma)
        c(sample_mean = mean(x), sample_sd = sd(x))
    }

We will estimate the values for this function a 100 times with different parameters `mu` and `sigma`. First, we will set up a parameter grid determining the combinations of parameters to use::

    par_grid <- expand.grid(mu = -5:5, sigma = seq(3, 33, 10), nrep = 1:100)

Then, the information about jobs based on the parameter grid is added to the registry. Here, the variables in the parameter grid would serve as arguments for our `get_random_mean2` function::

    jobs <- batchMap(get_random_mean2, par_grid)

To avoid throttling the cluster with a lot of tiny jobs, it's a good idea to "chunk" them so that a single  `qsub` call would execute multiple jobs::

    jobs$chunk <- chunk(jobs$job.id, chunk.size = 1000)

Finally, the jobs are submitted and we can wait until they are executed with a nice progress bar::

    submitJobs(jobs)
    waitForJobs()

When the jobs are completed, the only thing you need to do is to collect the results, here is one way to do it::

    res <- reduceResultsDataTable() # get the results as data.table
    res <- cbind(par_grid, res) # combine with the job parameters
    head(res)

      mu sigma nrep job.id    result
    1 -5     3    1      1 -5.092094
    2 -4     3    1      2 -3.966893
    3 -3     3    1      3 -2.710425
    4 -2     3    1      4 -1.905095
    5 -1     3    1      5  -1.03062
    6  0     3    1      6 0.4160899

