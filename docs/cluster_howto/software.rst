Running supported software in the cluster
*****************************************

Commonly used data analysis/process software are centrally managed and supported in the cluster. A list of the supported software can be found `here <http://intranet.donders.ru.nl/index.php?id=torque-software>`_. The repository where the software are organised and installed is mounted to the ``/opt`` directory on every cluster node.

.. tip::

    You are welcomed to take initiative for introducing a new software in the repository, with the awareness of the maintainer's responsibility. See :ref:`software-maintainer` for more detail.

.. toctree::
    :maxdepth: 1

        Using environment modules <software-modules.rst>
        Using utility scripts <software-scripts.rst>
        Maintaining software <software-maintainer-responsibility.rst>