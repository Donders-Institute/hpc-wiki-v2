Working with text files
***********************

Given the simplicity and readability, text files are widely used in computing system for various purposes. In this practice, we will use text files to store numerical data. A benefit of storing data in text file is that many tools coming along with the Linux system can be used directly to process the data.

In the examples below, we will create two text files to store the final-exame scores of four students in the mathematics and language courses.  We will then introduce few usueful Linux commands to browse and analysis the data.

Before we start, make sure the directory ``$HOME/tutorial/labs`` is already available; otherwise create it with

.. code-block:: bash

    $ mkdir -p $HOME/tutorial/labs


and change the present working directory to it:

.. code-block:: bash

    $ cd $HOME/tutorial/labs

Creating and editing text file
==============================

There are many text editors in Linux.  Here we use the editor called ``nano`` which is relatively easy to adopt. Let's firstly create a text file called ``score_math.dat`` using the following command:

.. note::
    In Linux, the suffix of the filename is irrelevant to the file type. Use the ``file`` command to examine the file type.

.. code-block:: bash

    $ nano score_math.dat

You will be entering an empty editing area provided by ``nano``. Copy or type the following texts into the area:

.. code-block:: bash

    Thomas 81
    Percy 65
    Emily 75
    James 55

Press :kbd:`Control-o` followed by the :kbd:`Return` key to save the file.  Press :kbd:`Control+x` to quit the editing environment and return to the prompt.

Now repeat the steps above to create another file called ``score_lang.dat``, and paste the data below into it.

.. code-block:: bash

    Thomas 53
    Percy 85
    Emily 70
    James 65

When you list of the content of the present working directory, you should see the two data files.

.. code-block:: bash

    $ ls -l
    total 0
    -rw-r--r-- 1 honlee tg 40 Sep 30 15:06 score_lang.dat
    -rw-r--r-- 1 honlee tg 37 Sep 30 15:06 score_math.dat

Browsing text file
==================

Several commands can be used to brows the text file.  First of all, the command ``cat`` can be used to print the entire content on the terminal.  For example:

.. code-block:: bash

    $ cat score_math.dat

When the content is too large to fit into the terminal, one uses either ``more`` or ``less`` command to print contents in pages. For example,

.. code-block:: bash

    $ more score_math.dat
    $ less score_math.dat

.. Tip::
    The command ``less`` provides more functionalities than the ``more`` command such as up/down scrolling and text search.

When the top and bottom of the content are the only concern, one can use the commands ``tail`` and ``head``. To print the first 2 lines, one does

.. code-block:: bash

    $ head -n 2 score_math.dat

To print the last 2 lines, one does

.. code-block:: bash

    $ tail -n 2 score_math.dat

Searching in text file
======================

For search a string in text file, one use the command ``grep``.  For example, if we would like to search for the name ``Thomas`` in the file ``score_math.dat``, we do

.. code-block:: bash

    $ grep 'Thomas' score_math.dat

.. Tip::
     ``grep`` supports advanced pattern searching using the `regular expression <http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_01.html>`_.
