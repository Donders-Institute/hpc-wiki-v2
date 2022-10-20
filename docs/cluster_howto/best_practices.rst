Best practices of running jobs on the HPC cluster
*************************************************

In this section, we try to collect various best practices that may be helpful for speeding up your data analysis.  Please note that they are developed with certain use-case. Therefore, unless it's mentioned to be general, take a practice carefully and always think twice whether it's applicable to your data analysis.

If you have questions about the best-practices below or suggestions for new ones, please don't hesitat to contact `the TG helpdesk <mailto:helpdesk@fcdonders.ru.nl>`_.

Avoid massive short jobs
========================

The scheduler in the HPC cluster is in favor of less-longer jobs over massive-short jobs. The reason is that there are extra overhead for each job in terms of resource provision and job output staging.  Therefore, if feasible, stacking many short jobs into one single longer job is encouraged.

With the longer job, your whole computation task will also be done faster given the fact that whenever a resource is allocated for you, you can utilise it longer to make more computations.

A trade-off of this approach is that if a job fails, more computing time is wasted. This can be overcome with a good bookeeping in such that results from the finished computations in a job is preserved, and the finished computations do not need to be re-run.

Utilise the scratch drive on the compute node
=============================================

If your compute jobs on the cluster produce intermediate data during the process, using the scratch drive locally on the compute node has two benefits:

* It saves storage space in your home or project directory.
* For some usecases, data I/O on local drive can be faster than on the home and project directory provided by a network-attached storage.

The scratch drive is job specific (i.e. each job has its own scratch drive).  Within the context of the job, the path of the scratch drive is available via one of the following environment variables: ``$TMP``, ``$TEMP``, ``$TMPDIR`` and ``$TEMPDIR``.  With these four variables, it should make most of the applications use the scratch drive for temporary data ([why these variables?](https://en.wikipedia.org/wiki/TMPDIR)).  If you are writing your own temporary data, make sure that you use one of the variables to create temporary data files.  For instance, in a bash script:

.. code-block:: bash

    tmpfile=${TMP}/mytmp.data
    
Data in the scratch drive will be removed immediately after the job is completed.
    
Avoid massive output to STDOUT
==============================

It may be handy (and quick) to just print analysis result to the screen (or, in the other word, the standard output).  However, if the output is lengthy, it can results in very large STDOUT file produced by your compute jobs.  Multiplying the amount of parallel jobs you submitted to the system, it will ends up with filling up your home directory.  Things can easily go wrong when your home directory is full (i.e. out of quota), such as data loss.

A good advicce is to output your analysis to a file with good data structure.  Most of analysis tools provides their own data structures, e.g. the ``.mat`` file of MATLAB or the ``.RData`` file of R.
