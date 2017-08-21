# Change Having to type password on Sudo command

Open terminal window and type:

`sudo visudo`

In the bottom of the file, type the follow:

`username ALL=(ALL) NOPASSWD: ALL`