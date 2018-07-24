#!/usr/bin/env bash

## What Script was before...

# hosts="machine1 machine2 machine3"
# 
# for i in $hosts; do
#     echo $i;
#     ssh $i sudo apt-automate;
# done;
# 
# sudo apt-automate\

## Current version...

## Colors
RED='\E[0;31m'
GREEN='\E[0;32m'
ORANGE='\E[0;33m'
BLUE='\E[0;34m'
PURPLE='\E[0;35m'
CYAN='\E[0;36m'
LGRAY='\E[0;37m'
DGRAY='\E[1;30m'
LRED='\E[1;31m'
LGREEN='\E[1;32m'
YELLOW='\E[1;33m'
LBLUE='\E[1;34m'
LPURPLE='\E[1;35m'
LCYAN='\E[1;36m'
NC='\E[0m'

### True Varabiles
var_true=true
var_false=false

#  Function to ssh into a each server and run the script
#  "apt-automate" living on each server.
#  
#  On each server, the user that runs "apt-automate"
#  needs to be able to run "apt-automate" without having to
#  enter the sudo password.
#
#  ##  The line to enter in visudo on each server    
#  ##  *user* ALL=(root) NOPASSWD: /usr/local/bin/apt-automate
#  
#  The second variable is to indicate wether sudo needs
#  placed in front of the apt-automate script.
updateservers()
{
    declare -a server=("${!1}")
    
    for i in "${server[@]}"; do
        echo ""
        echo -e "${CYAN} $i ${NC}"
        echo ""
        if [ "$2" = true ]; then
            ssh $i apt-automate
        else
            ssh $i sudo apt-automate
        fi
    done;
}

## Function to list each server and then run updateservers()
servers()
{
    ## Root users
    # local rootusrs_list=(
    #     # "ip address"
    # )    
    
    ## Users that need sudo
    # local sudousers_list=(
    #     # "ip address"
    # )
    
    ## Keeping just in case..
    #updateservers rootusrs_list[@] $var_true
    #updateservers sudousers_list[@] $var_false
}

## Run servers()
servers
    
echo
echo -e "${LCYAN} Upadate / Upgrade this computer... ${NC}";
echo
sudo apt-automate
