# Getting start with bash script 

A great feature of the Linux shell is its programming capability. This feature provides feasibility of managing complex computations. Before diving into [the syntax of the bash language](language.md), this session focuses on the basic of the bash script.  You will learn how to compose a simple bash script, make the script executable and run it as a shell command.

## The first script in action

Follow the steps below to write our first bash script, and put it in action.

- Change present working directory to `$HOME/tutorial/libs`

  ```bash
  $ cd $HOME/tutorial/libs
  ```

- Create a new text file called `hello_me.sh`

  ```bash
  $ nano hello_me.sh 
  ```

- Save the following texts into the file

  [gimmick:gist](ba8bdfc60ba76e65b044)

- Change the file permission to executable

  ```bash
  $ chmod a+x hello_me.sh
  ```

- Run the script as a command-line tool

  ```bash
  $ ./hello_me.sh
  ```

  Note: In addtion to just typing the script name in the terminal, we add `./` in front.  This enforces the system to load the executable (i.e. the script) right from the present working directory.

## Interpreter directive

Generally speaking, a shell script is essentially a text file starting with an ___interpreter directive___.  The interpreter directive specifies which interpreter program should be used to translate the file contents into instructions executed by the system. 

The directive always starts with `#!` (a number sign and an exclamation mark) followed by the path to the executable of the interpreter.  Since we are going to use the interpreter of the `bash` shell, the executable of it is `/bin/bash`.  

## Comments
Except for the first line that is meant for the interpreter directive, texts following a `#` (number sign) in the same line are treated as comments.  They will be ignored by the interpreter while executing the script.  In `bash`, there is no special syntax for block comments.

## Shell commands

Running shell commands via a script is as simple as typing the commands into the text file, just like they are in the termianl.  A trivial example is show on line 8 where the command `whoami` is called to get the user id.

## Variables

Variables are used to store data in the script. This is done by assigning value to variable. Two different ways are shown in the example script:

1. The first way is shown on line 12 where the variable `server` is given a value captured from the output of the `/bin/hostname` command.  For capturing the command output, the command is enclosed by a parenthesis `()` following the dollar sign `$`.

2. The second way shown on line 15 is simply assigning a string to the variable `msg`.

Note: when assignment value to variable, there SHOULD NOT be any space characters around the equal sign `=`.

Tip: [Environment variables](/linux/practice/start.md#Environment_variables) of shell are also accessible in the script.  For example, one can use `$HOME` in the script to get the path to the personal directory on the file system.

Note: Bash variables are type-free, meaning that you can store any type of data, such as a string, a number or an array of data, to a variable without declaring the type of it in advance. This feature results in speedy coding and enables flexibility in recycling variable names; but it can also lead to conflict/confusion at some point. Keep this feature in your mind when writing a complex code.
