Managing access permission of project data
******************************************

Data sharing within the project directory is controlled by a role-based mechanism implemented around the `NFSv4 Access Control List <http://www.citi.umich.edu/projects/nfsv4/linux/using-acls.html>`_ technology.

User roles
==========

In the project storage, access permission of an user is governed by the user's **role** in the project. There are the four **roles** defined for the access control.  They are listed below:

===============  ================
role             permissions
===============  ================
**Viewer**       User in this role has read-only permission.
**Contributor**  User in this role has read and write permission.
**Manager**      User in this role has read, write permission and rights to grant/revoke roles of other users.
**Traverse**     User in this role has permission to "pass through" a directory. This role is only relevent to a directory. It is similar to the ``x``-bit of the :ref:`linux filesystem permission <linux_file_permission>`. See :ref:`the usage of the traverse role <project_storage_traverse_role>`.
===============  ================

Any user who wants to access data in a project directory must acquire one of the roles in the project. Users in the **Manager** role can grant/revoke user roles.

Tool for viewing access permission
==================================

For general end-users, a tool called ``prj_getacl`` (as **Project Get ACL**) is used to show user roles of a given project.  For example, to list the user roles of project ``3010000.01``, one does

.. code-block:: bash

    $ prj_getacl 3010000.01
    /project/3010000.01/:
         manager: honlee
     contributor: martyc
          viewer: edwger
        traverse: mikveng

One could also apply the ``prj_getacl`` program on a path (file or directory) in the project storage.  For example,

.. code-block:: bash

    $ prj_getacl /project/3010000.01/rdm-test
    /project/3010000.01/rdm-test/:
         manager: honlee
     contributor: martyc
          viewer: mikveng,edwger

.. note::
    * The name ``prj_getacl`` should be taken as "Project Get ACL"; thus the last character of it should be the lower-case of the letter ``L``.
    * Use the ``-h`` option to see additional options supported by ``prj_getacl``.

Tool for managing access permission
===================================

For the project manager, the tool called ``prj_setacl`` (as **Project Set ACL**) is used for altering user roles of a project.  For example, to change the role of user ``rendbru`` from **Contributor** to **Viewer** on project ``3010000.01``.  One does

.. code-block:: bash

    $ prj_setacl -u rendbru 3010000.01

.. note::
    The name ``prj_setacl`` should be taken as "Project Set ACL"; thus the last character of it should be the lower-case of the letter ``L``.

Similarly, setting ``rendbru`` back to the **Contributor** role, one does the following command:

.. code-block:: bash

    $ prj_setacl -c rendbru 3010000.01

To promote ``rendbru`` to the **Manager** role, one uses the ``-m`` option then, e.g.

.. code-block:: bash

    $ prj_setacl -m rendbru 3010000.01

For removing an user from accessing a project, another tool called ``prj_delacl`` (as **Project Delete ACL**) is used.  For example, if we want to remove the access right of ``rendbru`` from project ``3010000.01``, one does

.. code-block:: bash

    $ prj_delacl rendbru 3010000.01
    
.. note::
    The name ``prj_delacl`` should be taken as "Project Delete ACL"; thus the last character of it should be the lower-case of the letter ``L``.

Changing access permission for multiple users
---------------------------------------------

When changing/removing roles for multiple users, it is more efficient to combine the changes into one single ``prj_setacl`` or ``prj_delacl`` command as it requires only one loop over all existing files in the project directory.  The options ``-m`` (for manager), ``-c`` (for contributor) and ``-u`` (for viewer) can be used at the same time in one ``prj_setacl`` call. Furthermore, multiple users to be set to (removed from) the same role can be specified as a comma(``,``)-separated list with the ``prj_setacl`` and ``prj_delacl`` tools.

For example, the following single command will set both ``honlee`` and ``rendbru`` as contributor, and ``edwger`` as viewer of project ``3010000.01``:

.. code-block:: bash

    $ prj_setacl -c honlee,rendbru -u edwger 3010000.01

The following single command will remove both ``honlee`` and ``edwger`` from project ``3010000.01``:

.. code-block:: bash

    $ prj_delacl honlee,edwger 3010000.01

.. _project_storage_subdir:
Controlling access permission on sub-directories
------------------------------------------------

It is possible to set/delete user role on sub-directory within a project directory. It is done by using either the ``-p`` option, or directly specifying the absolute path of the directory.  Both ``prj_setacl`` and ``prj_delacl`` programs support it.

When doing so, the user will be automatically granted with (or revoked from) the ``traverse`` role on the parent directories if the user hasn't had a role on them.

For example, granting user ``edwger`` with the contributor role in the subdirectory ``subject_001`` in project ``3010000.01`` can be done as below:

.. code-block:: bash

    $ prj_setacl -p subject_001 -c edwger 3010000.01

Alternatively, one could also do:

.. code-block:: bash

    $ prj_setacl -c edwger /project/3010000.01/subject_001

If it happens that the user ``edwger`` doesn't have any role in directory ``/project/3010000.01``, ``edwger`` is also automatically granted with the :ref:`traverse role <project_storage_traverse_role>` for ``/project/3010000.01``.  This is necessary for ``edwger`` to "traverse through" it for accessing the ``subject_001`` sub-directory.

.. note::
    In this situation, user ``edwger`` has to specify the directory ``/project/3010000.01/subject_001`` or ``P:\3010000.01\subject_001`` manually in the file explorer to access the sub-directory.  This is due to the fact that the user with traverse role cannot see any content (files or directories, including those the user has access permission) in the directory. 

.. _project_storage_traverse_role:
The **Traverse** role
^^^^^^^^^^^^^^^^^^^^^

When granting user a role in a sub-directory, a minimum permission in upper-level directories should also be given to the user to "pass through" the directory tree.  This minimum permission is referred as the **Traverse** role.

The traverse role is automatically managed by the ``prj_setacl`` and ``prj_delacl`` programs when managing the access in a sub-directory or a file within a project directory. See :ref:`Controlling access permission on sub-directories <project_storage_subdir>`.
