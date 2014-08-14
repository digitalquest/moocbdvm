#!/bin/bash

# This script is a wrapper for the other update scripts. It is to be in /usr/local/bin/ and call the other scripts in a different directory

# TODO change this for appropriate dir
PathToRepository=http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git

cd /vagrant/update

if [ -d ".git/" ]; then
 # Git was initiated in a previous call, we can pull the sources

    git pull

else
# Git needs to be initiated

    git clone $PathToRepository ./

fi

cp maj-maj.sh /usr/local/bin/

