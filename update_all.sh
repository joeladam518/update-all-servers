#!/usr/bin/env bash

hosts="machine1 machine2 machine3"

for i in $hosts;
do
  echo $i;
  ssh $i sudo apt-automate;
  done;

sudo apt-automate