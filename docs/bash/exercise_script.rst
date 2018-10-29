Exercise: Putting Commands into a Script, and Setting the Script as Executable
******************************************************************************

.. Note::
    DO NOT just copy-and-paste the commands for the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.
    
Preparation
===========

Download a text file using the following command:

.. code-block:: bash

    $ rm -f gcutError_recon-all.log
    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/linux/exercise/gcutError_recon-all.log

This data file is an example output file from a freesurfer command submitted to the cluster using qsub. In this simple task we are going to try to extract some information from it using a few commands.

Task
====

In This task, we're going to create a script, set it as executable (make it so we can run it), and put it on the path

#. Make a directory called ``~/Scripts``. If you can't remember the command to do this, google for it.

   .. Hint::
        Remember that ``~`` refers to your home directory.

#. We're going to start making a scrpt that you will build on in the next exercise.

   Since a script is really just a text file, open a text editor and then enter the following lines.

   .. code-block:: bash

        #!/bin/bash

        # Lines beginning with # are comments. These are not processed by BASH, except in one special case.
        # At the beginning of a script, the first line is special.
        # It tells Linux what interpreter to use, and is called the interpreter directive.
        # If someone tries to execute a BASH script that does not have the #!/bin/bash line,
        # and they are using a different shell (tcsh, ksh, etc), then the script
        # will not probably not work correctly.
        # This is because different shells use different syntax.
        # The syntax of the interpreter directive  is a  #! followed immediately by the absolute path of the interpreter you'd like to use.
        # In most GNU/Linux systems, BASH is expected to live in the /bin folder, so it's full path is normally /bin/bash.

   This is the beginning of every BASH script with some useful commentary added. Comments in BASH are marked with the pound (``#``) sign.

#. So far this script will do nothing if run because it only contains an interpreter directive and commentary. We are going to add some commands to the script to make it do something.

   Recall the previous execise where you grep'd over the log file. If we want to save those commands to use again, a script is a very good way to do that.

   Add the following commands to your script following the commantary:

   .. code-block:: bash

        $ cat gcutError_recon-all.log | grep "Subject[0-9][0-9]" | head -1

#. Save this file as ``~/Scripts/logSearch.sh``

#. Set the script as executable with the following command

   .. code-block:: bash

        $ chmod +x ~/Scripts/logSearch.sh

   .. Note::
        This step is extrememly important. Your script will not run unless you tell linux that it can be run. This is a security thing. In the chmod (change mode) command, ``+x`` is an option meaning "plus executable," or set this file to have permission to execute for all users. For more and potentially confusing information, run the command

        .. code-block:: bash

            $ man chmod

#. Next we will show how you can run your script.

   In Linux, executable files are treated fairly similary whether they are scripts or binary programs. To run an executable, you generally need to type it's name in, and it will execute.

   You only need to make sure BASH knows where to look for the executable you want to run. There are different ways to do so:

   * You can run the executable by typing in the full (absolute) path of the script.
   * You can use the path relative to your current working directory.
   * You can add the location of the executable to your ``$PATH`` environment variable.

   Try to run your script by first using the relative path, then the absolute path. Raise your hand, if you don't understand this instruction.

   .. Hint::
        The character ``.`` refers to your current directory. In BASH, you need to indicate that you want to run an executable in your current directory by prefacing the command with ``./`` For example, if you want to executa a script, ``myscript.sh`` in your current directory, you would type ``./myscript.sh``.

#. Now that you've run your script using the absolute and relative paths, try to add ``~/Scripts`` to your ``$PATH`` environment variable.

   .. Hint::
        * Checkout this :ref:`useful information <change-the-path-variable>`
        * Remember that you need to add directories to your path, not files. When you type a command and hit enter, BASH will search all the directories on your path for a file matching what you typed. Do not add files directly to your path. BASH will not be able to find them.

#. See that you can run the script just by typing the name of it now! WOW!!

   When an executable file is on your path, you can just type its name without giving any information about its location in the file system. If you specify the path of a file in the command, i.e by prepending a ``./`` or ``/the/path/to/file`` to the file name, BASH will ignore your path variable and look in the location you specify.

The take away from all this is that instead of typing

.. code-block:: bash

   $ cat gcutError_recon-all.log | grep "Subject[0-9][0-9]" | head -1

Every time you want to run this command, you can just run the script you made in this exercise.

As you might be thinking already, you can add as many lines as you want to a script. If you open the script back up with your favorite text editor, you can add anything you want to extend its functionality.
