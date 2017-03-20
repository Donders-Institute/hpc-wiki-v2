Exercise: play with text-based data file
****************************************

.. note::
    Please try not just copy-n-pasting the commands provided in the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

Preparation
===========

Download :download:`this data file <../exercise/gcutError_recon-all.log>` using the following command:

.. code-block:: bash

    $ wget http://dccn-hpc-wiki.rtfd.io/en/latest/_downloads/gcutError_recon-all.log

This data file is an example output file from a freesurfer command submitted to the cluster using qsub. In this simple task we are going to try to extract some information from it using a few commands.

Your Task
=========

#. Construct a Linux command pipeline to get the subject ID associated with the log file. The subejct ID is of the form Subject##, i.e Subject01, Subject02, Subject03, etc. Use one command to send input to grep, and then use grep to search for a pattern. If you're a bit confused, take a look at the hints and the example grep command below. You'll have to modify it to get the result you want.

   .. Hint::
       * Commands separated with a pipe, the ``|`` character, send the output of the command to the left of the pipe as input to   the command on the right of the pipe.

       * Think back on :doc:`the exercise about wildcards <exercise_wildcards>`. ``grep`` uses something called **regular expressions** that are similar to wildcards, but much more extensive. For ``grep`` regexps, ``*`` and ``[]`` work the same way as they do in wildcards. For a fuller treatment of regexps, click `here <http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_01.html>`_. For a quick example see below. You can ``grep`` for a search term in a file with something like the following:

         .. code-block:: bash

             #example grep command
             $ cat file.txt | grep SEARCHTERM
             # where searchterm can be something like
             $ cat file.txt | grep "[0-9][0-9].*"
             # this search term would find matches in strings that start with two numbers followed by anything

#. If you completed Task 1, you were able to find the output you wanted, but there was much more output sent to the screen than you needed. Construct another pipeline to limit the output of `grep` to only the first line.

   .. Hint::
       Think of a command that prints the first n lines of a file. You can always google the task if you can't think of the right tool for the job.

Solution
========

.. .. include:: exercise_textfile_solution.rst

Closing Remarks
===============

These are just simple examples. You see the real power of the unix command line tools when you add a little, soon to come, scripting know-how. A simple example of a more powerful way to use grep is in a case where you have 543 subject logs (not impossible!), and you need to search through all of them for subjects who participated in a version of your experiment with a bad stimuli list. grep is an excellent tool for this!
