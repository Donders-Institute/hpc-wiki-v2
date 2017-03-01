Running computations on the Mentat compute nodes
************************************************

From one of the cluster's access node, you can login to one of the mentat compute nodes via SSH and run computations. The mentat comput nodes are namde from ``mentat203`` to ``mentat208``.  Each of them is equipped with 4 CPU cores and 16 gigabytes of memory.

The mentat compute nodes are designed to support the following use cases:

* developing and testing algorithms
* computations require more than 72 hours of walltime

For other type of computations, it is encouraged to use :doc:`the Torque cluster <compute_torque>`.

Examples below assume that you are connected to one of the cluster's access nodes via VNC following [this instruction](access.md).

Choosing a node
===============

Choosing a mentat compute node is a manual step.  `This page <http://torquemon.dccn.nl/>`_ helps you to find a lessly loaded node at the time you start the computation.  However, due to the freedom that user can start new computations at any time, load on the chosen node can change largly during your computation.

Computation in text mode
========================

1. login to the chosen mentat compute node (e.g. ``mentat203``) with SSH

    .. code-block:: bash

        $ ssh mentat203

2. run a program interactively, e.g.

    .. code-block:: bash

        $ matlab

Computation in graphic mode
===========================

1. accept X-window applications on any host to display graphic interface on the access node

    .. code-block:: bash

        $ xhost +

2. use SSH X11Forwarding to launch a X-window application on the mentat compute node.  The following command launches Matlab with the graphic desktop on ``mentat203``:

    .. code-block:: bash

        $ ssh -Y mentat203 'source /etc/bashrc; matlab -desktop'
