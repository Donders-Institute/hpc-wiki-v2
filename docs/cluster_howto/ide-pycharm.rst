.. _ide_pycharm:

PyCharm
*******

`PyCharm <https://www.jetbrains.com/pycharm/>`__ is one of the most popular integrated development environment (IDE) for Python projects.  PyCharm features a full integration with git(hub) support, and contains a rich project-based editor, as well as integrated python and bash terminals to run your python code or applications.

Moreover, if you `create a free account <https://www.jetbrains.com/shop/eform/students/>`__ on the Pycharm website with your university email, you can make use of the PyCharm Pro version, which supports working with Jupyter notebooks from within the Pycharm IDE (which makes for a much better experience than using the browser as a notebook front-end).

To run PyCharm on a cluster execution node simply run:

.. code-block:: bash

    $ pycharm

You will encounter a graphical dialog through which you can select the PyCharm version you like to use (the wrapper then submits a job to the cluster).

Assuming that you have followed the :ref:`Python exercise <exercise_python>`, we could load the ``demo`` conda environment as an example.  Here are steps to follow:

#. Start a new project, go to PyCharm's ``Settings`` -> ``Project`` -> ``Python Interpreter`` and select your ``demo`` conda environment (you may have to click on ``Show All``). 

#. Close the settings and open a bash command shell using the ``Terminal`` button in the bottom of the main window. You could now check in the terminal whether the ``nibabel`` Python module we installed earlier is still available by running: ``$ python nibabel_example.py``.

#. Alternatively, use the menu to open the file in the editor and then the ``Run`` menu to run or debug the example code. This should give the same results as before.