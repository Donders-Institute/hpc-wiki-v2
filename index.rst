.. HPC wiki documentation master file, created by
   sphinx-quickstart on Thu Feb 23 21:02:32 2017.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

The HPC wiki
************

About the wiki
==============

This wiki contains materials used by the :doc:`Linux and HPC workshop <tutorials>` held regularly at `Donders Centre for Cognitive Neuroimaging (DCCN) <http://donders.ru.nl>`_. The aim of this workshop is to provide researchers the basic knowledage to use the High-Performance Computing (HPC) cluster for data analysis. During the workshop, the wiki is used in combination with lectures and hands-on exercises; nevertheless, contents of the wiki are written in such that they can also be used for self-learning and references.

There are two major sessions in this wiki. :doc:`The Linux basic <docs/linux/index>` consists of the usage of the Linux operating system and an introduction to the Bash scripting language.  After following the session, you should be able to create text-based data files in a Linux system, and write a bash script to perform simple data analysis on the file.  :doc:`The cluster usage <docs/cluster_howto/index>` focuses on the general approach of running computations on the Torque/Maui cluster.  After learning this session, you should be knowing how to distribute data analysis computations to the Torque/Maui cluster at DCCN.

Table of Contents
=================

.. toctree::
   :maxdepth: 2

   The HPC environment <docs/index.rst>
   Linux tutorial <docs/linux/index.rst>
   BASH tutorial <docs/bash/index.rst>
   The HPC cluster <docs/cluster_howto/index.rst>
   The project storage <docs/project_storage/index.rst>
   Tutorials <tutorials.rst>


.. extra tables and indices
    Indices and tables
    ==================

    * :ref:`genindex`
    * :ref:`modindex`
    * :ref:`search`
