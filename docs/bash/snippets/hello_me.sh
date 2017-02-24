#!/bin/bash

# The -n option of echo command do not print the new line character at the end,
# making the output from the next command to show on the same line.
echo -n "Hello!  "

# Just run a system command and let the output printed to the screen
whoami

# Here we capture the output of the command "/bin/hostname",
# assigning it to a new variable called "server".
server=$(/bin/hostname)

# Here we compose a text message and assign it to another variable called "msg".
msg="Welcome to $server"

# Print the value of the variable "msg" to the terminal.
echo $msg
