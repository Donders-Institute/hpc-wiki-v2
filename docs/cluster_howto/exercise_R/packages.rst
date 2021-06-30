.. _r-packages:

R packages
**********

R users are encouraged to install their favorite R packages within the ``R_LIBS_USER`` directory which is by default in the user's home directory.  For exampl, you could using the following command to install a R package:

.. code-block:: r

    > install.packages("package name")

Since it can save users' effort (and storage space) in managing the dependencies, commonly used R packages are installed and maintained centrally by the TG in the directory of ``/opt/R-packages``.  Centrally installed R packages are built for different R versions.

.. note::
    Centally installed R packages only available for R version >= 4.0.1.

Using the centrally installed R packages
=========================================

The centrally installed R packages are made available via the ``R-packages`` environment module with the version number matching the version of R.

For instance, to access the packages built for R version 4.1.0, one does:

.. code-block:: bash

    $ module load R-packages/4.1.0

before starting the R session.

.. note::
    Under the hood, the ``R-packages`` module simply sets the variable ``R_LIBS_SITE`` to the path where the packages are installed.

You can then load the package you want by

.. code-block:: r

    > library(package)

.. note::
    If you are using rstudio, you don't even need to load the R-packages module in advance.  You could simply run the ``rstudio`` wrapper script in your VNC session.  The dialog contains a tickbox for making the centally installed packages available.

Installing your own packages
=============================

When installing your own packages, you could define the installation location by setting the variable ``R_LIBS_USER`` before you start R.  The default value defined by R is ``$HOME/R/x86_64-pc-linux-gnu-library/{version}`` where ``{version}`` is the R version.

.. note::
    R packages are sometimes compiled against their dependent libraries and the R version you use to install them.  You might need to re-install them for a different R version or after the dependent libraries are upgraded in the cluster.

Hereafter are instructions for installing specific packages:

* :ref:`rstan-install`


