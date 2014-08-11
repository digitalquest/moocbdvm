#!bin/bash

# TODO change this for appropriate dir
PathToRepository=http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git

mkdir -p /vagrant/TP

cd /vagrant/TP

if [ -d ".git/" ]; then
 # Git was initiated in a previous call, we can pull the sources

    git pull

else
 # Git needs to be initiated

    git clone $PathToRepository ./

fi
