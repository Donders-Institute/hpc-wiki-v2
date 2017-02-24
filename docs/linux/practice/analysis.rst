Extracting information from data
********************************

This practice will continue work on the two data files created in :doc:`Working with text (data) file <textdata>`.  The aim is to present how to extract interesting information out of the data, using some simple but powerful command-line tools of Linux.

You should have the following two files in the present working directory:

.. code-block:: bash

    $ cat score_math.dat
    Thomas 81
    Percy 65
    Emily 75
    James 55

    $ cat score_lang.dat
    Thomas 53
    Percy 85
    Emily 70
    James 65

Data sorting
============

If we wonder who has the highest score in the language course, a way to get the answer is applying the ``sort`` command on the text file.  For example,

.. code-block:: bash

    $ sort -k 2 -n -r score_lang.dat
    Percy 85
    Emily 70
    James 65
    Thomas 53

Here we use option ``-k`` to sort data on the second column, ``-n`` to treat the data as numerical value (instead of text characters by default), and make the sorting decendent with option ``-r``.  Voila, Percy has the highest score in the language class.

Data processing
===============

Using the ``awk``, a pattern scanning and processing language, one can already perform some statistical calculation on the data without the need of advanced tools such as `R <http://www.r-project.org>`_.  The example below shows a way to calculate the arithmetic mean of the score in the language class.

.. code-block:: bash

    $ awk 'BEGIN {cnt=0; sum=0;} {cnt += 1; sum += $2;} END {print "mean:", sum/cnt}' score_lang.dat
    mean: 68.25

The example above shows the basic structure of the ``awk`` language. It consists of three parts. For the explanation here, we call them the **pre-processor**, **processor** and **post-processor**.  They are explained below:

* **Pre-processor** starts with a keyword ``BEGIN`` followed by a piece of codes enclosed by the curly braces (i.e. ``BEGIN{ ... }``).  It defines what to do before ``awk`` starts processing the data file.  In the example above, we initiate two variables called ``cnt`` and ``sum`` for storing the number of students and the sum of the scores, respectively.

* The context of the **processor** is merely enclosed by the curly braces (i.e. ``{ ... }``), and it follows right after the pre-processor.  The processor defines what to do for each line in the data file.  It uses the index variables to refer to the data in a specific column in a line.  The variable ``$0`` refers to the whole line; and variables ``$n`` to the data in the n-th column.  In the example, we simply add ``1`` to the conunter ``cnt``, and increase the ``sum`` by the score taken from the 2nd column.

* **Post-processor** is initiated with a keyword ``END`` with context enclosed again by another curly braces (i.e. ``END{ ... }``).  Here in the example, we simply calculate the arithmetic mean and print it.

Data filtering
==============

One can also use ``awk`` to create filters on the data. The example below selects only those with score lower than 70.

.. code-block:: bash

    $ awk '{ if ( $2 < 70 ) print $0}' score_math.dat
    Percy 65
    James 55

Data processing pipeline
========================

Every running command is treated as a process in the Linux system.  Every process is attached with three data streams for receiving data from an input device (e.g. a keyboard), and for printing outputs and errors to an output device (e.g. a screen). These data streams are technically called ``STDIN``, ``STDOUT`` and ``STDERR`` standing for the **standard input**, **standard output** and **standard error**, respectively.

An import feature of these data streams is that the output stream (e.g. ``STDOUT``) of a process can be connected to the input stream (``STDIN``) of another process to form a data processing pipeline. The very symbol for constructing the pipeline is ``|``, the **pipe**.

In the following example, we assume that we want to make a nice-looking table out of the two score files.  The table will list the name of the student, the score for each class, and the total score of the student.

Firstly we have to put the data from the two text files together, using the ``paste`` command:

.. code-block:: bash

    $ paste score_lang.dat score_math.dat
    Thomas 53    Thomas 81
    Percy 85     Percy 65
    Emily 70     Emily 75
    James 65     James 55

But the output looks ugly! Furthermore, it's just half way to what we want to have. It is where the process pipeline plays a role.  We now revise our command to as the follows:

.. code-block:: bash

    $ paste score_lang.dat score_math.dat | awk 'BEGIN{print "name\tlang\tmath\ttotal"; print "---"} {print $1"\t"$2"\t"$4"\t"$2+$4}'
    name    lang    math    total
    ---
    Thomas  53      81      134
    Percy   85      65      150
    Emily   70      75      145
    James   65      55      120

.. note::
    In the Linux shell, the string ``"\t"`` represents the ``Tab`` key.  It is a way to align data in a column.

Here the pipeline is constructed in such that we firstly put together the data in the two files using the ``paste`` command, and connect the output stream of it to the input stream of the ``awk`` command to create the nice-looking table.

Saving output to file
=====================

When you have processed the data and produced a nice-looking table, it would be a good idea to save the output to the file rather than print to the screen. Here we will discuss another important feature of the ``STDOUT`` and ``STDERR`` data streams: the output redirection.

The following command will produce the nice-looking table again, but instead of printing table to the terminal, it will be saved to a file called ``score_table.txt`` by redirecting the output.

.. code-block:: bash

    $ paste score_lang.dat score_math.dat | awk 'BEGIN{print "name\tlang\tmath\ttotal"; print "---"} {print $1"\t"$2"\t"$4"\t"$2+$4}' > score_table.txt

.. Tip::
     Output redirection with ``>`` symbol will override the content of an existing file.  One could use the ``>>`` symbol to append new data to the existing file.

Note that the above command only redirects the ``STDOUT`` stream to a file, data to the ``STDERR`` stream will still be printed to the terminal.

There are two approaches to save the ``STDERR`` stream to file:

1. Merge ``STDERR`` to ``STDOUT``

.. code-block:: bash

    $ paste score_lang.dat score_math.dat | awk 'BEGIN{print "name\tlang\tmath\ttotal"; print "---"} {print $1"\t"$2"\t"$4"\t"$2+$4}' > score_table.txt 2>&1

2. Save ``STDERR`` to separate file

.. code-block:: bash

    $ paste score_lang.dat score_math.dat | awk 'BEGIN{print "name\tlang\tmath\ttotal"; print "---"} {print $1"\t"$2"\t"$4"\t"$2+$4}' 1>score_table.txt 2>score_table.err
