Exercise: file system operations
********************************

.. note::
    Please try not just copy-n-pasting the commands provided in the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

In this exercise, we will get you familiar with the Linux file system.  Following the steps below, you will perform certain frequently used commands to perform operations on the file system, including

* browsing files and sub-directories within a directory,
* creating and removing directory,
* moving current working directory between directories,
* changing access permission of a directory,
* creating and deleting files.

You will also learn few useful wildcard syntax to make things done quicker and easier.

Tasks
=====

#. Change the present working directory to your personal directory

   .. code-block:: bash

       $ cd $HOME

#. Create a new directory called ``tutorial``

   .. code-block:: bash

       $ mkdir tutorial

#. Change the present working directory to the ``tutorial`` directory

   .. code-block:: bash

       $ cd tutorial

#. Create two new directories called ``labs`` and ``exercises``

   .. code-block:: bash

       $ mkdir labs
       $ mkdir exercises

#. Remove all access permissions of ``others`` from the ``exercises`` directory

   .. code-block:: bash

       $ chmod o-rwx exercises

#. Set ``groups`` to have read and execute permissions on the ``exercises`` directory

   .. code-block:: bash

       $ chmod g=rx exercises

#. Change the present working directory to ``$HOME/tutorial/labs``

   .. code-block:: bash

       $ cd $HOME/tutorial/labs

#. Create multiple empty files (and list them) using wildcards.  Note the syntax ``{1..5}`` in the first command below. It is taken by the Linux shell as a serious of sequencial integers from ``1`` to ``5``.

   .. code-block:: bash

       $ touch subject_{1..5}.dat

       $ ls -l subject_*
       -rw-r--r-- 1 honlee tg 0 Sep 30 16:24 subject_1.dat
       -rw-r--r-- 1 honlee tg 0 Sep 30 16:24 subject_2.dat
       -rw-r--r-- 1 honlee tg 0 Sep 30 16:24 subject_3.dat
       -rw-r--r-- 1 honlee tg 0 Sep 30 16:24 subject_4.dat
       -rw-r--r-- 1 honlee tg 0 Sep 30 16:24 subject_5.dat

   .. Tip::
       The ``touch`` command is used for creating empty files.

#. Remove multiple files using wildcards.  Note the syntax ``*``.  It is taken as "any characters" by the Linux shell.

   .. code-block:: bash

       $ rm subject_*.dat
