Managing access permission of project data
******************************************

Data sharing within the project directory is controlled by a role-based mechanism implemented around the `NFSv4 Access Control List <http://www.citi.umich.edu/projects/nfsv4/linux/using-acls.html>`_ technology.

User roles
==========

In the project storage, access permission of an user is governed by the user's **role** in the project. Hereafter are the four **roles** defined for the access control.

===============  ================
role             permissions
===============  ================
**Viewer**       User in this role has read-only permission.
**Contributor**  User in this role has read and write permission.
**Manager**      User in this role has read, write permission and rights to grant/revoke roles of other users.
**Traverse**     User in this role has permission to "pass through" a directory. This role is only relevent for a directory. It is similar to the ``x``-bit of the linux filesystem permission. See :ref:`the usage of the traverse role <project_storage_traverse_role>`.
===============  ================

Any user who wants to access data in a project directory must acquire one of the roles on the project. Users in the **Manager** role have rights to grant/revoke additional user roles.

Tool for viewing access permission
==================================

For general end-users, a tool called ``prj_getacl`` is used to show user roles of a given project.  For example, to list the user roles on project ``3010000.01``, one does

.. code-block:: bash

    $ prj_getacl 3010000.01
    +------------+---------------------+---------+-------------+---------+----------+
    |  project   |         path        | manager | contributor |  viewer | traverse |
    +------------+---------------------+---------+-------------+---------+----------+
    | 3010000.01 | /project/3010000.01 | honlee  |    martyc   | edwger  | rendbru  |
    +------------+---------------------+---------+-------------+---------+----------+

The script support few optional arguments. Some usefule ones are listed in the following table.

+----------------+-------------------------------------------------------------------------+
| Option         | Purpose                                                                 |
+================+=========================================================================+
| ``-h``         | print the help message with a full list of the command-line options     |
+----------------+-------------------------------------------------------------------------+
| ``-l LOGLEVEL``| set the verbosity of the log message in a level between ``0`` and ``3`` |
+----------------+-------------------------------------------------------------------------+
| ``-p SUBDIR``  | retrieve the access right on a ``SUBDIR`` within the project directory  |
+----------------+-------------------------------------------------------------------------+
| ``-b``         | run the access-right setting in batch mode, as a Torque cluster job     |
+----------------+-------------------------------------------------------------------------+

Tool for managing access permission
===================================

For the project manager, the tool called ``prj_setacl`` is used for altering user roles on a given project.  For example, to change the role of user ``rendbru`` from **Contributor** to **User** on project ``3010000.01``.  One does

.. code-block:: bash

    $ prj_setacl -u rendbru 3010000.01

Similarly, setting ``rendbru`` back to the **Contributor** role, one does the following command:

.. code-block:: bash

    $ prj_setacl -c rendbru 3010000.01

To promote ``rendbru`` to the **Manager** role, one uses the ``-m`` option then, e.g.

.. code-block:: bash

    $ prj_setacl -m rendbru 3010000.01

For removing an user from accessing a project, another tool called ``prj_delacl`` is used.  For example, if we want to remove the access right of ``rendbru`` from project ``3010000.01``, one does

.. code-block:: bash

    $ prj_delacl rendbru 3010000.01

Recursive or non-recursive
--------------------------

By default, the ``prj_setacl`` and ``prj_delacl`` only modify the access permission on the top-level directory (e.g. the root of the project directory).  Therefore only the newly created files/directories within the project will adopt the new access permission.

In order to apply the modification on the existing files/directories under the top-level directory, one needs to use the ``-r`` and ``-f`` options.  For example, the following command makes user ``rendbru`` as manager of all existing files/directories in the project ``3010000.01``:

.. code-block:: bash

    $ prj_setacl -r -f -m rendbru 3010000.01

.. warning::
    When changing the access permission recursively, one important behaviour to keep in mind is that the new permission setting of the top-level directory (e.g. the root of the project directory) will **overwrite** the existing settings of all the files/sub-directories.

    This feature is to ensure access permissions are set consistently across all sub-directories. **If you are managing different access permissions in sub-directories, you should be careful on this "overwriting" feature.**

Changing access permission for multiple users
---------------------------------------------

When you have to change access permission for multiple users, it is more efficient to combine the changes into one single ``prj_setacl`` or ``prj_delacl`` command as it requires only one loop over all existing files in the project directories.  The options ``-m`` (for manager), ``-c`` (for contributor) and ``-u`` (for viewer) can be used at the same time in one ``prj_setacl`` call. Furthermore, in ``prj_setacl`` and ``prj_delacl``, users can be specified as a comma(``,``)-separated list.

For example, the following single command will set both ``honlee`` and ``rendbru`` as contributor, and ``edwger`` as viewer of project ``3010000.01``:

.. code-block:: bash

    $ prj_setacl -c honlee,rendbru -u edwger 3010000.01

The following single command will remove both ``honlee`` and ``edwger`` from project ``3010000.01``:

.. code-block:: bash

    $ prj_delacl honlee,edwger 3010000.01

Controlling access permission on sub-directories
------------------------------------------------

.. warning::
    Using this feature can significantly complicate the access-control management. Therefore the usage of it is not encouraged unless there is a good reason (and you are fully aware of the consequences).

    Given this reason, the feature is locked by default. If you want to use this feature for your project, please contact the TG helpdesk.

It is possible to set/delete user role on sub-directory within a project directory, using the ``-p`` option of the ``prj_setacl`` and ``prj_delacl`` scripts.

For example, granting user ``edwger`` with the contributor role in the subdirectory ``subject_001`` in project ``3010000.01`` can be done as follows:

.. code-block:: bash

    $ prj_setacl -p subject_001 -c edwger 3010000.01

.. _project_storage_traverse_role:

The **Traverse** role
^^^^^^^^^^^^^^^^^^^^^

When granting user a role in a sub-directory, a minimum permission in upper-level directories should also be given to the user to "pass through" the directory tree.  This minimum permission is given by assiging the user to the **Traverse** role.

In practice, the assignment is more meaningful when it takes place at the time the user is given a role to a sub-directory, therefore, it is done via the ``-t`` option of the ``prj_setacl`` command.

For example, the following command gives user ``rendbru`` the **Contributor** role in the subdirectory ``subject_001``, as well as the minimum permission (i.e. the **Traverse** role) to pass through the top-level directory of project ``3010000.01``.

.. code-block:: bash

    $ prj_setacl -t -p subject_001 -c rendbru 3010000.01
