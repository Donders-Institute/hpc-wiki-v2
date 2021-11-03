Exercise: Using Wildcards
*************************

.. note::
    Please try not just copy-n-pasting the commands provided in the hands-on exercises!! Typing (and eventually making typos) is an essential part of the learning process.

Preparation
===========

Move into a directory you'd like to work in (make a new directory if you like), and run the command

.. code-block:: bash

    $ touch gcutError_recon-all.log s10_recon-all.log s1_recon-all.log s6_recon-all.log s8_recon-all.log

This will create empty files for the purpose of this exercise.

Background
==========

A handy way to refer to many items with a similar pattern is with wildcards. These were described so far in the lectures, but mainly consist of the characters:

* ``*`` matches everything
* ``?`` matches any single character
* ``[]`` matches any of the letters or numbers, or a range of letters or numbers inside the brackets

With BASH, the shell itself expands the wildcards. This means that the commands usually don't see these special characters because BASH has already expanded them before the command is run. Try to get a feel for wildcards with the following examples

.. code-block:: bash

    $ ls *recon-all.log
    gcutError_recon-all.log  s10_recon-all.log  s1_recon-all.log  s6_recon-all.log	s8_recon-all.log

.. code-block:: bash

    $ ls gcut*
    gcutError_recon-all.log

.. code-block:: bash

    $ ls s[0-9]*
    s10_recon-all.log  s1_recon-all.log  s6_recon-all.log  s8_recon-all.log

.. code-block:: bash

    $ ls s[0-9]_*
    s1_recon-all.log  s6_recon-all.log  s8_recon-all.log

.. code-block:: bash

    $ ls s[0-9][0-9]_*
    s10_recon-all.log

.. code-block:: bash

    $ ls [a-z][0-9][0-9]???con-all.log
    s10_recon-all.log

.. code-block:: bash

    $ ls s?_recon-all.log
    s1_recon-all.log  s6_recon-all.log  s8_recon-all.log

Do you understand all of the patterns and how they returned what they did?

The ``[ ]`` wildcard has the most complex syntax because it is more flexible. When BASH sees the ``[ ]`` characters, it will try to match any of the characters or a range of characters it sees inside them. A range of characters is specified by separating two search characters with the ``-`` character. Some legal patterns would be ``[0-9]``, ``[5-8]``, ``[a-Z]``, or ``[ady1-3]``. Another handy trick is to use the ``!`` character to negate a search pattern inside ``[]``. For instance, ``[!0-9]`` means don't return anything with a value between `0` and `9`. Take a look at next examples to get a feel for this very useful globbing character.

* matching all strings starting with ``s1`` followed by any of numbers from ``0`` to ``9``, followed then by anything.

  .. code-block:: bash

      $ ls s1[0-9]*
      s10_recon-all.log

* matching all strings starting with any of a range of letters from ``a`` to ``Z``

  .. code-block:: bash

      $ ls [a-Z]*
      gcutError_recon-all.log  s10_recon-all.log  s1_recon-all.log  s6_recon-all.log s8_recon-all.log

* matching all strings starting with ``s``, ``g``, or ``0``.

  .. code-block:: bash

      $ ls [sg0]*

* matching all strings that do not start with ``s``

  .. code-block:: bash

      $ ls [!s]*
      gcutError_recon-all.log

Your Task
=========

#. Find a search pattern that will return all files ending in ``.txt``
#. Find a search pattern that will return all files starting in ``s`` and ending in ``.log``
#. Find a search pattern that will return all files starting ``s`` followed by two numbers
#. Find a search pattern that will return all files only starting ``s`` followed by one number

Solution
========

.. include:: exercise_wildcards_solution.rst

Clean up
========

When your finished and have checked the solution, run the command below to remove the files we were working with. If you don't do this, the next exercise will give you trouble.

.. code-block:: bash

    $ rm gcutError_recon-all.log s10_recon-all.log s1_recon-all.log s6_recon-all.log s8_recon-all.log
