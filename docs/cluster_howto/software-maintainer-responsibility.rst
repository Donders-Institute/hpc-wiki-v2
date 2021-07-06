.. _software-maintainer:

HPC software maintainer
***********************

In the HPC cluster, we organize commonly used software in a repository that is mounted under the ``/opt`` directory on all HPC nodes.

While generic and widely used software such as MATLAB, Python, Anaconda, etc. are maintained by the TG, there is also software that requires domain-specific knowledge (e.g., Freesufer, FSL, fmriprep) and that is therefore maintained by researchers.

Introducing new software
========================

As a HPC user, you may request new software to be installed, especially if you see potential benefit to the wider group of users of the HPC cluster. Please send your request and initiate a discussion with the TG by sending a `helpdesk ticket <mailto:helpdeskt@fcdonders.ru.nl>`_.

If the request is approved, a maintainer needs to be identified. It can be the TG if the software is a generic tool/framework and if the TG feels capable to maintaine it on the longer term, or it can be a researcher (usually the person who makes the request).

Once the maintainer is identified, the TG will create two directories under ``/opt`` and ``/opt/_modules`` for the software and its module files, respectively. Those directories will be owned by the maintainer's user account in the HPC cluster so that the maintainer can take responsibility and has the full permission to modify their  contents.

Maintainer responsibility
=========================

As the maintainer of a specific software package, you are responsible for the following tasks:

* making a maintenance plan

  The maintainer should make a short plan for keeping the package up-to-date. Such a plan could for instance exist of checking a github page for new releases or subscribing to a mailinglist. The maintenance plan should be stored as part of the description in the ``common.tcl`` file of the software module.

* installing new software version

  The maintainer performs installation of a new software version whenever there is a request from user, or based on the upgrade plan. If the TG helpdesk receives a request for a new version, it will be forwarded to the maintainer to follow it up.
    
  After the new version has been installed and tested successfully, the maintainer should set the newly installed version as the default, and communicate it with the users (via email or the Mattermost HPC channel).

* maintaining the environment module for the software

  Following installation of a software package, the maintainer should also provide a module file so that user can use the software by loading the module. Technical information on this can be found in :ref:`software-maintainer-module-howto`. The TG can support you to overcome initial technical hurdles.

* supporting users on software-specific issues

  When a user of a specific software package reports issues , the TG helpdesk can be contacted as the first-line support. If the issue is identified to be software-specific (or specific knowledge from the maintainer is needed), the TG will forward the issue to the maintainer to help the user.
    
  As a maintainer, you may also write utility scripts to support users. It is recommended to store those scripts in the software directory under ``/opt``, and make sure the scripts are not depending on files outside the ``/opt``.

* identifying successor and handing over responsibility for maintenance

  When the maintainer is about to leave the centre, the maintainer should identify a successor or the software will become unmaintained. The responsibility for software maintenance does not automatically move over to the TG. 

  Unmaintained software is left in the repository as it is, until there is a new request asking for updating the software. When that happens, the TG will discuss with the user who makes the request to take over the maintainer responsibility. 

  Unmaintained software are targets for deletion when the storage space of ``/opt`` needs to be reclaimed.

Should there be issues while performing those tasks, the maintainer can always contact the TG and ask for help.