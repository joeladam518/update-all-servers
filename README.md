# update-all-servers
Scripts to auto update all my servers

Where I got it from and then modified: 

http://www.greenfly.org/tips/apt-automate.html

Note: This tip was originally posted in a thread on the Ars Technica Linux Kung Fu Forum.

http://episteme.arstechnica.com/eve/ubb.x?a=tpc&s=50009562&f=96509133&m=6480986585&r=6480986585#6480986585

On each machine you want to automate do the following steps:

    Install sudo

    Create a shell script, "/usr/local/bin/apt-automate" which contains the following code:

    #!/bin/sh

    apt-get update && apt-get -u upgrade

    Edit your /etc/sudoers file using the "visudo" command and add the following line:

    username ALL=(root) NOPASSWD: /usr/local/bin/apt-automate

    where "username" is replaced by the username you will use to remotely ssh into this machine. 

The update_all.sh script will go through all the machines I specify in the hosts variable, and run the apt-automate on that machine. After it is done looping through, it will run it locally as well. So now, whenever I want to update all the servers on my network, I just run update_all and watch it work.

Note that this should work on any system that has apt-get available in some form along with sudo and ssh. What I have done in addition is make sure that the user I run update_all as, has passwordless ssh access to each of those servers (using RSA keys), so I don't have to bother with typing in passwords for each server when I run the command. 
