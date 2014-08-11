#!bin/bash

cd /vagrant/TP

if [ -d ".git/" ]; then
 # Git was initiated in a previous call, we can pull the sources

    git pull

else
 # Git needs to be initiated

    git clone $PathToRepository ./

fi
