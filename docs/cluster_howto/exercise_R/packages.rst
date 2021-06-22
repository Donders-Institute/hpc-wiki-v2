.. _r-packages:

R packages
**********

R users are encouraged to install their favorite R packages within the ``R_LIBS_USER`` directory which is by default in the user's home directory, using the following command, for example:

.. code-block:: R

    > install.packages("package name")

Nevertheless, having commonly used R-packages installed centrally is beneficial for saving user's time (and storage space in the home directory) in managing the depandancies.  In the cluster, several third-party R packages are installed and maintained by the TG in the directory of ``/opt/R-packages``.  Under this directory, packages are built for different R versions later than 4.0.1.

.. note::
    Centally installed R packages are version dependent; and only introduced for R versions >= 4.0.1. 

Using centrally installed R packages
=====================================

The centrally installed R packages can be loaded by using the ``R-packages`` module.

If you want to make use of a centrally installed package in your R session with version 4.1.0, you could do:

.. code-block:: bash

    $ module load R-packages/4.1.0

before you start a R session.

.. note::
    Under the hood, the ``R-packages`` module simply set the variable ``R_LIBS_SITE`` to a path where the packages are located.

Within the R session, all centrally installed packages will be available.  You can then load the package with

.. code-block:: r

    > library(package)

.. note::
    If you are using rstudio, you don't even need to load the R-packages module in advance.  Simply run the ``rstudio`` wrapper script in your VNC session.  The dialog contains a tickbox for making the packages available in the rstudio session.

Installing your own packages
=============================

When installing your own packages, you could define the installation location by setting the variable ``R_LIBS_USER`` before you start R.  The default value defined by R is ``$HOME/R/x86_64-pc-linux-gnu-library/{version}`` where ``{version}`` is the R version.

.. note::
    Please be noted that the R packages are sometimes compiled against their dependent libraries and the R version you use to install them.  You might need to re-install them for a different R version or after the upgrade of system libraries and the operating system.

Hereafter are installation instructions for specific packages:

* :ref:`rstan-install`


