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

* Data I/O on local drive is faster than on the home and project directory provided by a network-attached storage.
* It saves storage space in your home or project directory.

The scratch drive on the compute node is mounted on the path of ``/data``.  A general approach of storing data on it is to create a subdirectory under the ``/data`` path, and make the name specific to your job.  For exampl, you could introduce a new environment variable in the BASH shell called ``LOCAL_SCATCH_DIR`` in the following way:

.. code-block:: bash

    export LOCAL_SCRATCH_DIR=/data/${USER}/${PBS_JOBID}/$$
    mkdir -p ${LOCAL_SCRATCH_DIR}

Whenever you want to store intermediate data to the directory, use the absolute path with prefix ``${LOCAL_SCRATCH_DIR}``. For example,

.. code-block:: bash

    cp /home/tg/honlee/mydataset.txt ${LOCAL_SCRATCH_DIR}/mydataset.txt

It would be nice if your job also takes care of clean up of the data in the `/data` directory.  For example,

.. code-block:: bash

    rm -rf ${LOCAL_SCRATCH_DIR}

Generally speaking, it's not really necessary as data in this directory will be automatically removed after 14 days. However, it may help other users (and yourself) to utilise the local scratch for large datasets if space is not occupied by finished jobs.

Avoid massive output to STDOUT
==============================

It may be handy (and quick) to just print analysis result to the screen (or, in the other word, the standard output).  However, if the output is lengthy, it can results in very large STDOUT file produced by your compute jobs.  Multiplying the amount of parallel jobs you submitted to the system, it will ends up with filling up your home directory.  Things can easily go wrong when your home directory is full (i.e. out of quota), such as data loss.

A good advicce is to output your analysis to a file with good data structure.  Most of analysis tools provides their own data structures, e.g. the ``.mat`` file of MATLAB or the ``.RData`` file of R.
