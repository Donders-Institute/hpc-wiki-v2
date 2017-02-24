Solution to Task 1
------------------

.. code-block:: bash

    $ cat gcutError_recon-all.log | grep "Subject[0-9][0-9]"
    /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer
    -subjid FreeSurfer -i /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/Scans/Anatomical/MP2RAGE/MP2RAGE.nii -all
    setenv SUBJECTS_DIR /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05
    /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer
    mri_convert /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/Scans/Anatomical/MP2RAGE/MP2RAGE.nii /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer/mri/orig/001.mgz
    mri_convert /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/Scans/Anatomical/MP2RAGE/MP2RAGE.nii /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer/mri/orig/001.mgz
    reading from /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/Scans/Anatomical/MP2RAGE/MP2RAGE.nii...
    writing to /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer/mri/orig/001.mgz...
    /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer/mri/orig/001.mgz
    cp /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer/mri/orig/001.mgz /home/language/dansha/Studies/LaminarWord/SubjectData/Subject05/FreeSurfer/mri/rawavg.mgz

.. Hint::
    Note that you could also have run the command

    .. code-block:: bash

        $ grep "Subject[0-9][0-9]" gcutError_recon-all.log

    to get the same results. The traditional unix command line tools typically provide many ways of doing the same thing. It's up to the user to find the best way to accomplish each task. grep is an excellent tool. To learn more about what you can search, try man grep. You can also google for something like "cool stuff I can do with grep."

Solution to Task 2
------------------

.. code-block:: bash

    $ grep "Subject[0-9][0-9]" gcutError_recon-all.log | head -1

You could have also done

.. code-block:: bash

    $ grep -m 1 "Subject[0-9][0-9]" gcutError_recon-all.log
    $ cat gcutError_recon-all.log | grep "Subject[0-9][0-9]" | head -1
    $ cat gcutError_recon-all.log | grep -m 1 "Subject[0-9][0-9]"

There are usually many ways to do the same thing. Look up the -m option in the grep man page if you're curious!
