#!/bin/bash

#ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#chmod 0600 ~/.ssh/authorized_keys


service ssh start 

cd /usr/local/hadoop/sbin/
./start-dfs.sh
./start-yarn.sh

cd ~

/bin/bash

