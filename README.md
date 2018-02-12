# update-all-servers
Scripts to auto update all my servers


Note: This tip was originally posted in a thread on the Ars Technica Linux Kung Fu Forum.

I finally finished up a quick and simple system to automate updates throughout all of my systems. It's only a couple of steps and saves a lot of work.

On each machine you want to automate do the following steps:

    Install sudo

    Create a shell script, "/usr/local/bin/apt-automate" which contains the following code:

    #!/bin/sh

    apt-get update && apt-get -u upgrade

    Edit your /etc/sudoers file using the "visudo" command and add the following line:

    username ALL=(root) NOPASSWD: /usr/local/bin/apt-automate

    where "username" is replaced by the username you will use to remotely ssh into this machine. 

After you have done this on each machine, to update all the machines issue the following command:

HOSTS="machine1 machine2 machine3 machine4"; for i in $HOSTS; do ssh $i sudo apt-automate; done;

This will go to each machine and run apt-automate, which just runs apt-get update && apt-get upgrade, downloading and installing the latest packages. If you have different users on different machines, just replace "machine1" with "username@machine1" for each machine.

You could also potentially create a file with a list of the machines you have this set up on (especially if you have a lot), say, /etc/apt-automate, and then run:

HOSTS=`cat /etc/apt-automate`; for i in $HOSTS; do ssh $i sudo apt-automate; done;

What I have done instead is create the following script, called "update_all" and put it in /usr/local/bin:

#!/bin/sh

hosts="machine1 machine2 machine3"

for i in $hosts;
do
  echo $i;
  ssh $i sudo apt-automate;
  done;

sudo apt-automate

This script will go through all the machines I specify in the hosts variable, and run the apt-automate on that machine. After it is done looping through, it will run it locally as well. So now, whenever I want to update all the servers on my network, I just run update_all and watch it work.

Note that this should work on any system that has apt-get available in some form along with sudo and ssh. What I have done in addition is make sure that the user I run update_all as, has passwordless ssh access to each of those servers (using RSA keys), so I don't have to bother with typing in passwords for each server when I run the command. 