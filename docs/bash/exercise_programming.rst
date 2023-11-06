Exercise: the *if*-statement and *for*-loop
*******************************************

Introduction
============

In this exercise we will be extending ``script.sh`` by adding some BASH flow control constructions. We will be working with ``if`` and ``for``. The ``if``-statement and the ``for``-loop are probably the most common flow control tools in the bash hackers toolbox.

The overall goal of this lengthy exercise is to introduce ``for``-loops and ``if``-statements and show you a common use case in which they are put together with what you have learned in pervious sessions for actual works. As an example, we will show you how to search for a specific pattern in a collection of log files and print out certain information from the log files given a condition.

The exercise consists of two main sections broken into subtasks. The two main sections focus respectively on ``if`` and ``for``, and the subtasks are designed to introduce these tools and illustrate their utility.

Task 1: simple ``for`` loop
===========================

Background
----------

We will construct a simple ``for``-loop to demonstrate how it works.

The ``for``-loop works by iterating over a list of items and executing all the commands in the body once for each item in the list. The general form is:

.. code-block:: bash

    for variable-name in list-of-stuff; do
        commands
        more commands
    done

You can add as many commands as you like. BASH will loop through the commands in the body of the loop as many times as there are items in your list. You can see [the wiki](language.md) for more information.

Your Task
---------

#. Add a list of items to this `for`-loop and see what happens. A list can be a list of files, strings, numbers, anything.

   .. code-block:: bash

        for i in INSERT-LIST-HERE; do
            echo $i
        done

   Replace the ``INSERT-LIST-HERE`` with ``$(ls ${HOME})`` and see how it changes ``i`` to the next item on the list each time it iterates.

#. In this next one, try to add any command you want to the body of the ``for``-loop

   .. code-block:: bash

        for i in {01..10}; do
            INSERT-COMMANDS-HERE
            INSERT-MORE-COMMANDS-HERE-IF-YOU-LIKE
        done

   .. Tip::
        Bash takes a range of items within ``{}`` and expands it before running any commands. For example, ``{01..05}`` will expand to ``01 02 03 04 05``. You can use letters or numbers. See `this link <http://www.linuxjournal.com/content/bash-brace-expansion>`_ for more information.

   The main things to remember are that the variable name, list and commands are totally arbitrary and can be whatever you like as long as you keep the correct syntax. Also note that you can have any number of items in the list as you want, you can set the variable name to whatever you want, and you can use any commands you want. You don't even need to reference the variable in the body. For example, try running

   .. code-block:: bash

        for i in {01..05}; do
            echo 'hello world!'
        done

   .. Hint::
        Notice the syntax. The first line ends in ``do``, the next commands are indented, and ``done``, the keyword which ends the loop, is at the same indentation level as the keyword ``for``, which begins the loop. This is how all your for loops should look.

Task 2: Use the ``for`` loop in a BASH script
=============================================

Background
----------

We will extend the functionality of our current script with the ``for``-loop. For this exercise, we deal with the common scenario of needing to search through a collection of log files for specific information.

Preparation
-----------

Start by downloading the :download:`log files <logs.tgz>` we'll be using. Move into a directory you'd like to work in and run this command to download and `untar <https://xkcd.com/1168/>`_ the logfiles.

.. code-block:: bash

    $ wget https://github.com/Donders-Institute/hpc-wiki-v2/raw/master/docs/bash/logs.tgz
    $ tar xvf logs.tgz

Now open ``script.sh`` and change your ``grep`` command to the one you see below. The ``-o`` option tells grep to print ONLY the matching pattern, and not the rest of the line around it. This will be useful later in the task and in general.

.. code-block:: bash

    #!/bin/bash

    # Lines beginning with # are comments. These are not processed by BASH, except in one special case.
    # At the beginning of a script, the first line is special. It tells Linux what interpreter to use, and is called, accordingly, the _interpreter directive.

    grep -o "Subject[0-9][0-9]" gcutError_recon-all.log | head -1

Your task
---------

Using this command as a starting point, create a ``for``-loop to grep the Subject ID of every log file we've downloaded.

To accomplish this goal you will need to do the following:

#. Create a for loop which iterates over a list consisting of the log files.

#. Modify the grep command to search through the current log file and not "gcutError_recon-all.log".

#. Run your script.

   The structure will be something like this:

   .. code-block:: bash

       for var in list-of-logs; do
           grep -o search-term file-to-search | head -1
       done

   .. note::
       Always remember to include all the special keywords: ``for`` , ``in`` , ``;`` , ``do`` , and ``done``. If you don't remember these, you might not get an error, but your loop definitely won't run.

Task 3: simple ``if`` statement
===============================

Background
----------

Often in programming, you want your program or script to do something if certain conditions are met, and other things if the conditions are not met. In BASH, as well as many other languages, a very common way of exerting this type of control over your program is an ``if``-statement.

The purpose of ``if`` is to test if a command returns an exit status of 0 (zero) or not 0, and then run some commands if the exit staus is ``0``. You can also say to run commands if the exit status is not ``0``. This is what the keyword ``else`` means.

Recall that, in BASH, the ``if``-statement syntax is

.. code-block:: bash

    if command-returns-true; then
        run these commands
    else
        run-these-commands-instead
    fi

``true`` means exit status ``0`` (BASH tracks every process' exit status), and the else portion is optional.
Any non-zero exit status would be not true, i.e false.

Note: For the gory details, refer back to the slides, the wiki, or suffer the `agony <http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html>`_ of this fairly exhasutive treatment.

Your task
---------

#. Modify the following ``if``-statement code using the command ``true``.

   .. code-block:: bash

        if INSERT-COMMAND-TO-EVALUATE; then
            INSERT-COMMANDS-TO-RUN-IF-TRUE
            INSERT-MORE-COMMANDS-TO-RUN-IF-TRUE
        else INSERT-COMMANDS-TO-RUN-IF-FALSE
            INSERT-MORE-COMMANDS-TO-RUN-IF-FALSE
        fi

   .. tip::
        ``true`` is a command which does nothing except return exit status 0, thus it always evaluates to true! The description in the man page is good for a chuckle. You'll want to make sure you put ``true`` as the **command to evaluate**. Remember to fill in the other commands too. The other commands can be whatever you like.

#. Now try using the command ``false`` instead of ``true``.

   .. note::
        Now the else portion of the code will be evaluated while the part before the else keyword will not be evaluated. Use the same template ``if``-statement as you did in subtask 1.

Task 4: Comparitive statements
==============================

Background
----------

In this task, you will extend the power of ``if`` by using it with `comparison operators of BASH <http://tldp.org/LDP/abs/html/comparison-ops.html>`_.

Task 3 demonstrated how ``if``-statements work, but their main use in scripting is testing if a comparison evaluates to true or false. This complicates the syntax.

For comparisons, you need to use a separate command called ``test``. In BASH, the most commonly seen form of ``test`` is ``[[ things-to-compare ]]``.

.. tip::
    You will also see the form ``[ things-to-compare ]``, which is simply a less featured version of ``[[ ]]``. They are both versions of the command ``test``. In general, you should always use the ``[[ ]]`` form. You can look to `this guide <http://mywiki.wooledge.org/BashFAQ/031>`_ for the a good explanation of test ``[ ]`` and ``[[ ]]``.

Your Task
---------

#. Modify the following ``if``-statement structure to test if the number on the left is less-than the number on the right.

   .. code-block:: bash

        if [[ 3 INSERT-OPERATOR 4 ]]; then
            echo "3 is less than 4"
        else
            echo "4 is not greater than 3"
        fi

   .. tip::
        Numerical comparison operators to use with ``[[ ]]`` are ``-lt``, ``-gt``, ``-ge``, ``-le``, ``-eq``, and ``-ne``. They mean, less-than, greater-than, greater-or-equal, etc.

   Now test if 3 is greater than 4 by using a different comparison operator.

#. Try the same command but with variables now instead of numbers. Modify this code, remembering to set values for variables ``num1`` and ``num2``.

   .. code-block:: bash

        num1=
        num2=
        if [[ $num1 INSERT-OPERATOR $num2 ]]; then
            INSERT-COMMANDS
        else
            INSERT-COMMANDS
        fi

   .. note::
        BASH only understands integers. Floating point arithmetic requires external programs (like ``bc``).

#. Now we will perform string comparisons.

   The main purpose of this is to see if some variable is set to a certain value. Strings use different comparison operators than integers. For strings we use ``==``, ``>``, ``<``, and ``!=``. By far the most common operators are ``==`` and ``!=`` meaning respectively equal and not equal.

   .. code-block:: bash

        string=

        if [[ $string == "A String" ]]; then
            echo "strings the same"
        else
            echo "strings are not the same"
        fi

   .. note::
        This one place where the difference between ``[[ ]]`` and ``[ ]`` becomes evident. With ``[ ]`` you will have to escape the ``<`` and ``>`` characters because they are special characters to the shell. With ``[[ ]]`` you don't have to worry about escaping anything. Recall in BASH that we use ``\`` to tell BASH to process the next character literally.

   .. note::
        If a string has a space in it the space has to be escaped somehow. One way of doing this is by using either single or double quotes.

Task 5: Put ``if`` and ``for`` together
=======================================

Background
----------

We will now return to our script with the ``for``-loop and extend the functionality by adding an ``if``-statement inside of the ``for``-loop.

In this task, we will find the amount of time each script which generated each logfile ran. We will print the run time and the logfile name to the screen if the runtime is below 9 hours. I've broken this rather large task into small steps. Raise your hand if you get lost! This one's hard.

Your Task
---------

#. In each logfile the "run-time" is recorded. It is the amount of time the freesurfer script which generated the logfile ran.

   Open your script and modify the grep command to search for the "run-time" instead of the subject ID. You'll need to remove the ``-o`` flag now because we'll need the full line.

   .. code-block:: bash

        #an example
        for file in list; do
            grep SEARCH-PATTERN $file
        done

   After correctly modifying grep and running the script,  you should have a bunch of lines output to the screen. They'll all be of the form:

   .. code-block:: none

        #@#%# recon-all-run-time-hours 5.525
        #@#%# recon-all-run-time-hours 10.225
        ...

   If you get output like this, move on to 2.

#. Restrict this output to ONLY numbers less than 10. In other words, find a search pattern that is only sensitive to one digit followed by a decimal. Then find a way to restrict the output further so that only the whole number remains, i.e 8.45 becomes simply 8.

   If you spend more than 10 minutes on this, look to the :ref:`solution <bash_exercise_programming_t5_q2>` and move on to 3!. This is a hard one, so I provide lots of hints.

   .. tip::
        #. You only need ``grep`` for this, not ``if``. Think about piping multiple grep commands together and of using regexes.
        #. The key to this question is getting the right regexp. There are a few ways you could do this.
        #. Remember that "space" is a character.
        #. If you want to search for a literal ``.`` character, you'll have to escape it with ``grep``, i.e ``\.`` and not ``.``.
        #. Be careful not to accidentally return only the second digit of a two digit number.
        #. In ``grep`` you don't negate the items inside ``[]`` with ``!`` as you do with wildcards, instead you use ``^``, i.e ``[^0-9]``, to mean **NOT** a number from 0 to 9 instead of ``[!0-9]``
        #. Finally, it's good practice in grep to put your search term in single or double quotes.

#. ``grep`` should be returning one digit numbers or nothing at all. This is what we want!

   In step 3, we will capture the output and save it to a variable. We will use this variable later for a numerical comparison involving ``if``. Recall command substitution. If you want to save the output of a command as a variable, use the syntax:

   .. code-block:: bash

        var=$(MY-COMMANDS-HERE)

   Insert your command into the parentheses and then insert that line in place of your current ``grep`` pipeline.

#. Now add an ``if``-statement to the body of the ``for``-loop and create a comparison, testing if the value ``grep`` returned is less than 9. If the value is less than 9, we want to print the name of the logfile and the variable value to the screen.

   .. code-block:: bash

        for file in list; do
            var=$(MY-GREP-PIPELINE)
            if [[ $var INSERT-OPERATOR INSERT-VALUE ]]; then
                DO SOMETHING
            fi
        done

   If you've done this correctly, you may notice an odd result. Even if ``$var`` is empty, your comparison will always evaluate to less than 9?! If this odd outcome is the same as yours, check the :ref:`solution <bash_exercise_programming_t5_q4>` and then move onto subtask 5!

   .. tip::
        An excellent trick is to ``echo`` the commands you will run before you run them. If, for example, you are (as you should be) worried that your search patterns are a bit too liberal, you can see what the loop will actually do by putting it in double-quotes and adding echo before it. Observe:

        .. code-block:: bash

            for file in list; do
                var=$(MY-GREP-PIPELINE)
                echo "if [[ $var INSERT-OPERATOR INSERT-VALUE ]]; then
                    DO SOMETHING
                fi"
            done

        Instead of running the commands, you've now told the ``for``-loop to echo what will actually be run to the screen. This is an important step in checking your own code for errors **before** you run it.

#. The reason ``$var`` is always less than 9, even when nothing is assigned to it is because empty strings evaluate to 0! To get around this you can add extra conditions to your ``if``-statement. Add an extra comparison that will test if ``$var`` is greater than zero. The syntax is like so:

   .. code-block:: bash

        for file in list; do
            var=$(MY-GREP-PIPELINE)
            if [[ $var INSERT-OPERATOR INSERT-VALUE && $var INSERT-OPERATOR INSERT-VALUE ]]; then
                DO SOMETHING
            fi
        done

   This will test if *both* conditions evaluate to true, and then run the command if both are true. You could also create a comparison using logical or with ``||``.

   As a result, if the run time is less than 9 hours and greater than 0 hours, we will print the log and the run time to the screen. Good work!

   .. note::
        For an even better solution, you can use what are called **unary operators**.  These are detailed among the `agonies <http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html>`_ of this fairly exhasutive treatment. They test if variables are empty strings, if files exist, etc. Note that this guide uses the ``[ ]`` form of ``test``, but you can use everything described there with the ``[[ ]]`` form as well.


Solutions
=========

.. .. include:: exercise_programming_solutions.rst
