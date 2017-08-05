# Permissions

> Permissions are granted with `chmod a+x filename`

If you run a `ls -l` in the cli you will get a list of files and folders with a string at the front like so:
* -rw-rw-r--
    * The first space will be blank for a file but `d` if it is a **directory**
    * The next three spaces represent permissions for **current user**
    * The next three **groups**
    * The next three **all users**
    * `x` = executable
    * `w` = writable
    * `r` = readable


> So when running `a+x` you are saying to make file executable for all users