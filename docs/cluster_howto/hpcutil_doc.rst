.. _hpcutil-usage:

The HPC utility
***************

The HPC utility (or ``hpcutil``) is an CLI tool developed by the Technical Group of DCCN. The usage of it is similar to the CLI of ``git`` where a group of (sub-)sub-commands are provided in a hierarchical manner.

The in-terminal help for a subcommand and the supported flags of it are always available via the ``-h`` option.  The CLI also supports tab-completion in `BASH <https://nl.wikipedia.org/wiki/Bash>`_ which means the suggested subcommands or flags is available by pressing the TAB key twice.

Currently, the CLI provides two main subcommands on the first level: ``cluster`` and ``webhook``.

The ``cluster`` subcommand
==========================

The ``cluster`` subcommand can be used to retrieve job or resource (node, software license) information of the HPC cluster.  To get the in-terminal help of the ``cluster`` subcommand, one uses the following command in the terminal:

.. code:: bash

    $ hpcutil cluster -h

where ``-h`` is optional.

It shows another level of subcommands that are available, for instance:

.. code:: bash

    Available Commands:
      config      Print Torque and Moab server configurations.
      job         Retrieve information about a cluster job.
      matlablic   Print a summary of the Matlab license usage.
      nodes       Retrieve information about cluster nodes.
      qstat       Print job list in the memory of the Torque server.

One can then take one from those available command to move onto another level of the sub-commands.  For example, if one wants to get nodes resource information, one does

.. code:: bash

    $ hpcutil cluster nodes

and via the supported subcommands shown below, you will be able to get resource information such as the disk/memory usage on a list of cluster nodes, or a summary table of the running VNC sessions on the cluster. 

.. code:: bash

    Available Commands:
      diskfree    Print total and free disk space of the cluster nodes.
      memfree     Print total and free memory on the cluster nodes.
      vnc         Print list of VNC servers on the cluster or a specific node.

Example: list MATLAB licenses allocated by DCCN users
-----------------------------------------------------

.. code:: bash

    $ hpcutil cluster matlablic

Example: list VNC sessions
--------------------------

To get all VNC sessions running on the cluster's access nodes, one can do:

.. code:: bash

    $ hpcutil cluster nodes vnc

To get VNC sessions on a given host (e.g. ``mentat001.dccn.nl``), one does:

.. code:: bash

    $ hpcutil cluster nodes vnc mentat001.dccn.nl

To get VNC sessions owned by a given user (e.g. ``honlee``), one does:

.. code:: bash

    $ hpcutil cluster nodes vnc -u honlee

One could combine the last two examples to find VNC sessions owned by a user on a specific host.  For example, the following command will find VNC sessions owned by user ``honlee`` on host ``mentat001.dccn.nl``.

.. code:: bash

    $ hpcutil cluster nodes vnc -u honlee mentat001.dccn.nl


Example: show all cluster jobs
------------------------------

.. code:: bash

    $ hpcutil cluster qstat

Example: check memory utilization of a running job
--------------------------------------------------

Assuming a running job with ID ``1234567``, the owner of the job can perform the following command to check the memory usage:

.. code:: bash

    $ hpcutil cluster job meminfo 1234567
    
or apply the command to the `watch <https://linux.die.net/man/1/watch>`_ command to monitor the memory usage in real time:

.. code:: bash

    $ watch hpcutil cluster job meminfo 1234567

Example: get job's trace log
----------------------------

Assuming a job with ID ``1234567``, the job trace log (in the last 3 days) can be obtained from the Torque server via the following command:

.. code:: bash

    $ hpcutil cluster job trace 1234567

The ``webhook`` subcommand
==========================

The ``webhook`` subcommand is used to manage the webhook facility of the HPC cluster.  To get the in-terminal help of the ``webhook`` subcommand, one uses the following command in the terminal:

.. code:: bash

    $ hpcutil webhook -h

where ``-h`` is optional.

Instructions about creating and enabling webhook is provided by `This link <https://github.com/Donders-Institute/hpc-webhook/blob/master/docs/instructions.md>`_. The instruction here will focus on the management perspective of the webhooks.

There are five subcommands supported:

.. code:: bash

    Available Commands:
      create      Create a new webhook.
      delete      Delete an existing webhook.
      info        Retrieve information of an existing webhook.
      list        List webhooks.
      trigger     Trigger webhook manually with a payload.
      
Example: create a new webhook
-----------------------------

Assuming that we want to create a new webhook associated with a Torque cluster job script ``qsub.sh`` (an example can be found `here <https://github.com/Donders-Institute/hpc-webhook/blob/master/test/data/qsub.sh>`_, we can used the following command:

.. code:: bash

    $ hpcutil webhook create qsub.sh
    
On success, it returns the actual webhook URL which can be then registered at a webhook trigger, such as the `webhook for a GitHub repository <https://developer.github.com/webhooks/>`_.

One could also give a short descript to the created webhook so that it can be easily identified later.  This is done through the ``-n`` flag.  For example,

.. code:: bash

    $ hpcutil webhook create qsub.sh -n "My first webhook"
    
Example: list available webhooks
--------------------------------

For listing available webhooks, one does:

.. code:: bash

    $ hpcutil webhook list
    
Every returned webhook has a unique id. For instance,

.. code::

    1e846adf-462b-4a7b-b183-651909072b79
	    Description     : My first webhook
	    Creation time   : 2019-04-03T08:28:38Z
	    Script path     : /home/tg/honlee/qsub.sh
	    Webhook URL     : https://hpc-webhook.dccn.nl:443/webhook/1e846adf-462b-4a7b-b183-651909072b79

This unique id, i.e. ``1e846adf-462b-4a7b-b183-651909072b79`` in the example above, is used in ``info``, ``delete`` and ``trigger`` subcommands to identify a webhook.

.. tip::

    The tab-completion is also applicable to the webhook ids.  This is useful to selecting a valid webhook id for the ``info``, ``delete`` and ``trigger`` subcommands.
    
Example: trigger a webhook
--------------------------

Normally the webhook is triggered externally upon an event (e.g. a commit to GitHub, a new message posted on Twitter, etc.).  The ``trigger`` subcommand here is only meant to help you test the webhook by manually trigger it with a provided payload.

Assuming we have prepared a GitHub webhook payload file called ``payload.json`` (some payload examples can be seen `here <https://github.com/Donders-Institute/hpc-webhook/tree/master/test/data>`_), we can trigger a webhook with ID ``1e846adf-462b-4a7b-b183-651909072b79`` with the payload using the following command:

.. code:: bash

    $ hpcutil webhook trigger 1e846adf-462b-4a7b-b183-651909072b79 -l payload.json -t json
    
where the ``-t json`` is redundent in this case as by default, the payload is take as JSON format.  If your payload is in another format (e.g. XML or plain text), you will need to use the ``-t`` option to specify it.
