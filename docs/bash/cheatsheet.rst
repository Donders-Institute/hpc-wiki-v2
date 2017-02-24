Useful information
******************

Navigation Keys and commands
============================

The ``^`` character indicates the :kbd:`Control` button.  When you see it next to another character, it means to hold down the Ctrl button while you push that character. For example, ``^c`` means to hold down Ctrl and then press the :kbd:`c` button while you are holding down :kbd:`Control`. In the case of ``^shift+c`` it means to hold down :kbd:`Control` AND :kbd:`Shift` buttons while pushing the :kbd:`c` button.

* :kbd:`^shift+c`: copy highlighted text in terminal. Highlight text by clicking and dragging, just like in any application.
* :kbd:`^shift+v`: paste text into terminal. Text copied from the terminal will be available in other applications using the typical :kbd:`^v` key combination.
* :kbd:`^c`: send the ``SIGINT`` signal to a program. Will usually quit any process currently running in the terminal. It will not quit certain programs, like nano, but it will by default terminate a running script.

.. comments
    |^a  |   Will move the cursor to the beginning of the line in the terminal|
    |^e  |   Will move the cursor to the end of the line in the terminal|
    |^k   |  WIll delete everything after the cursor on one line|
    |      | The rest of these aren't as important, but may still be useful to you|
    |^w |  Will delete one word backward from the cursor|
    |^b  | Will move the cursor one character backward|
    |^f   | Will move the cursor one character forward|
    |Alt-f |(hold down the Alt button and then press f) Will move the cursor one word forward|
    |Alt-b| Will move the cursor one word backward|
    |      | The next items are commands to be run at the terminal prompt|
    |$ cd - | change dir to the previous directory you were just in|
    |$ cd ../ | change dir to one directory back, you can move as many directories back with this syntax as you like|
    |$ cd ../../Dir| change dir to two directories back and one directory forward into the directory Dir (should be on one line)|
    |$ cd ~ | change dir to the home directory|

.. Note::
    These key combinations will not work with all terminal applications (i.e nano, etc) because specific programs may have the key combinations already assigned to another purpose. In other cases, the terminal program itself may not interpret these characters in a typical way.

Changing the ``PATH`` variable
==============================

At a BASH prompt, type:

.. code-block:: bash

    $ PATH=$PATH:/path/to/new/directory/

You can add as many directories as you like. If you want to add more the syntax would be

.. code-block:: bash

    $ PATH=$PATH:/path/to/first/directory/:/path/to/second/directory/:/and/so/on/

.. Note::
    If you find that none of your commands are found after you tried to change ``PATH``, then you have accidentally deleted you ``PATH`` variable. Restart bash (reopen the terminal application) and it will go back to normal.

Changing the ``$HOME/.bashrc``
==============================

First, it is a good idea to back up the file if you plan to make changes.

.. code-block:: bash

    $ cp ~/.bashrc ~/.bashrc.bak

Then you can open the bashrc file to modify with the command:

.. code-block:: bash

    $ nano ~/.bashrc

You will then see a minimal bashrc file that the TG has configured for every user.

Add whatever commands you would like to this file. A common thing to do is to alter the path variable to contain a directory with your personal scripts

To do this, you just add something like the following to the bottom. Note that you could enter the commands wherever you want in the bashrc, just keep in mind that they will be executed sequentially.

.. code-block:: bash

    PATH=$PATH:/usr/local/abin/:/usr/local/bin/mricron_lx/:/sbin/:/usr/local/bin/:/usr/local/Scripts/

Of course, you'll have to enter in your own directories for the PATH to make sense for you. There is no sense in copying and pasting these example PATHS.

Like on the command line, you can add as many directories as you want, just remember to separate them with the ``:`` character.

When you are finished modifying the file. Press :kbd:`^x` to exit, and nano will ask you if you want to save. Say yes. To have the current bash environment use the new bashrc, you can either start a new instance of bash, or run the command

.. code-block:: bash

    source ~/.bashrc

The source command just means to run the file as though you were typing in each command yourself, and not in a new bash instance (the behavior for scripts)

If we were to run the bashrc like a script, any variables we set in bashrc would not affect the parent environment.

Note: bashrc is a hidden file. It has a . character in front of it. This means that it will not be visible normally. You would need to run the command ``ls -a`` to see it in the output.

Process control (killing hung jobs)
===================================

If a process you are running, whether on the GUI or on the command line, becomes unresponsive and you cannot kill it by conventional means. You can use the kill command

First find the process ID that you want to stop. The following command will list all the processes being run by your username.

.. code-block:: bash

    $ ps ux

For example,

.. code-block:: bash
    :linenos:

    $ ps ux
    USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    dansha    4244  0.0  0.0 162256  3604 ?        Ss   Oct11   0:00 xterm
    dansha    4246  0.0  0.0 131076  3372 pts/0    Ss   Oct11   0:00 bash
    dansha    4342  4.6  0.1 578252 27800 ?        Rl   11:54   0:00 konsole
    dansha    4346  1.0  0.0 131076  3320 pts/12   Ss   11:54   0:00 /bin/bash
    dansha    4369  0.0  0.0 578492 16148 pts/0    Sl+  Oct11   0:01 xfce4-terminal
    dansha    4375  0.0  0.0  22980   896 pts/0    S+   Oct11   0:00 gnome-pty-helper
    dansha    4376  0.0  0.0 131084  3332 pts/3    Ss+  Oct11   0:00 bash
    dansha    4474  0.0  0.0 133648  1388 pts/12   R+   11:54   0:00 ps ux
    dansha    4729  0.0  0.0 131084  3336 pts/7    Ss+  Oct11   0:00 bash
    dansha    4920  0.0  0.0 131084  3392 pts/8    Ss+  Oct11   0:00 bash
    dansha    5104  0.0  0.0 162256  3604 ?        Ss   Oct11   0:00 xterm
    dansha    5106  0.0  0.0 131076  3256 pts/11   Ss+  Oct11   0:00 bash
    dansha    5617  0.0  0.0 162256  3804 ?        Ss   Oct06   0:00 xterm
    dansha    5619  0.0  0.0 131176  3568 pts/17   Ss+  Oct06   0:00 bash
    dansha    5711  0.0  0.0 376040   404 ?        Ss   Aug31   0:00 emacs -daemon
    dansha    7505  0.0  0.0  36732     4 ?        Ss   May20   0:00 /bin/dbus-daemon --fork --print-pid 6 --print-address 8 --session
    dansha    9568  0.0  0.0 433608  8796 ?        Sl   Oct09   0:00 /usr/libexec/tracker-store
    dansha    9572  0.0  0.0 304444  3132 ?        Sl   Oct09   0:00 /usr/libexec/gvfsd
    dansha    9576  0.0  0.0 286896  5344 ?        Sl   Oct09   0:00 /usr/libexec//gvfsd-fuse /run/user/10441/gvfs -f -o big_writes
    dansha   12361  0.0  0.0 143436  2244 ?        S    Oct07   0:00 sshd: dansha@notty
    dansha   12362  0.0  0.0  62932  1912 ?        Ss   Oct07   0:00 /usr/libexec/openssh/sftp-server
    dansha   12472  0.0  0.0 143568  2244 ?        S    Oct07   0:00 sshd: dansha@notty
    dansha   12473  0.0  0.0  69328  2148 ?        Ss   Oct07   0:00 /usr/libexec/openssh/sftp-server
    dansha   15633  0.0  0.0 143568  2436 ?        S    Oct07   0:00 sshd: dansha@pts/10,pts/15
    dansha   15634  0.0  0.0 129872  2116 pts/10   Ss+  Oct07   0:00 /bin/sh
    dansha   16263  0.0  0.0 128944  3076 pts/15   Ss+  Oct07   0:00 /bin/bash --noediting -i
    dansha   18069  0.0  0.6 275020 101536 ?       Sl   Oct04   5:24 /usr/bin/Xvnc :2 -desktop mentat208.dccn.nl:2 (dansha) -auth /home/language/dansha/.Xauthority -geometry 1910x10
    dansha   18078  0.0  0.0 115184  1540 ?        S    Oct04   0:00 /bin/bash /home/language/dansha/.vnc/xstartup
    dansha   18142  0.0  0.0  96760  4120 ?        S    Oct04   0:00 vncconfig -iconic -sendprimary=0 -nowin
    dansha   18143  0.0  0.0 159188  6988 ?        S    Oct04   0:06 fluxbox
    dansha   18284  1.0  1.9 1461168 318744 ?      Ssl  Oct04 112:48 /usr/lib64/firefox/firefox
    dansha   18313  0.0  0.0  28504   768 ?        S    Oct04   0:00 dbus-launch --autolaunch=d172390f877044d1a0919ebec6673565 --binary-syntax --close-stderr
    dansha   18314  0.0  0.0  37012   896 ?        Ss   Oct04   0:00 /bin/dbus-daemon --fork --print-pid 6 --print-address 8 --session
    dansha   18341  0.0  0.0 160184  2560 ?        S    Oct04   0:01 /usr/libexec/gconfd-2
    dansha   30537  0.0  0.0 406336  2536 ?        Sl   Sep22   0:15 /usr/bin/pulseaudio --start --log-target=syslog

The idea is to match the process ID (PID) with the command name. Any command you run (clicking on an icon is also a command) will have an entry in this table if the command created a process that is still running.

For example, to kill firefox process with PID ``18284``, one uses the command:

.. code-block:: bash

    $ kill 18284

If firefox still doesn't close, one could try

.. code-block:: bash

    $ kill -9 18284

.. Note::
    ``kill -9`` is kind of a nuclear option. Don't use it unless the program won't close normally with kill.

One could also combine the ``ps`` command with ``grep`` to find a running process.  For example, to find ``firefox`` processes, one does:

.. code-block:: bash

    $ ps ux | grep firefox
    dansha    4638  0.0  0.0 114708   984 pts/12   S+   11:56   0:00 grep --color=auto firefox
    dansha   18284  1.0  1.9 1461168 318744 ?      Ssl  Oct04 112:48 /usr/lib64/firefox/firefox

Be careful to enter in the right PID. If you enter in the wrong PID, it will kill that program instead. Think of this like ending the wrong process in the windows task manager.

.. Tip::

    1. If you want to save your work in nano without closing the program , press :kbd:`^o`.
    2. To read text files without editing them, use the program less. You can search through documents by typing / and then entering the search term you want to look up. Don't include spaces. You can use this same method to navigate man pages.
    3. To see if a program is on your path and where that program is on your path, use the command which.

Odd things to be aware of
=========================

These are some little things that have come up with users in the past. I may add more items to this in the future, but these topics are already pretty well addressed on forums.

1. In some terminal programs, accidentally pushing :kbd:`^s` will cause the terminal to lock up. If you notice your terminal is locked up and your not sure why, try pushing :kbd:`^q`

2. Sometimes terminal formatting can get messed up. You may notice that when you type long lines, new characters overwrite characters at the beginning of the line. Also, if you accidentally run cat on a binary file, you may notice your terminal may start displaying nonsense characters when you type. In both of these cases, you might try to run the command:

.. code-block:: bash

    $ reset

You may not be able to see what you type, but if you hit enter, type the command, and then hit enter again you might get your terminal back to normal. If that doesn't work, restart the terminal application.
