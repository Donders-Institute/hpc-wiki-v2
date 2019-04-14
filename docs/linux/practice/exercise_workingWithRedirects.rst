Exercise: Familiarize Yourselves with Redirects
****************************************

The typical shells used in Linux environments allow for redirecting input and output to additional commands. The basic redirects you will use today are > >> and |
You can generally use these redirects with any standard command line utility.

Your Task
=========

#. Either make a new directory or go to an existing directory that you made in the previous exercise. Take a few minutes to try each of these three redirects with arbitrary commands to improve your understanding of their functionality.

.. Hint::
    Try some commands like these shown below. Experiment with other commands you learned about in the slides this morning, or come of the commands on your cheat sheet. Notice that you can stack redirects multiple times, as in the first example. 

    
.. code-block:: bash

    $ ls /home | sort > file.txt
    $ echo hello > file.txt
    $ echo hello >> file.txt
