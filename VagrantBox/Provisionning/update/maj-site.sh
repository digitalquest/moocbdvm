#!bin/bash

# TODO change this for appropriate dir
PathToRepository=http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git

mkdir -p /var/html/bdsqlwiz

cd /var/html/bdsqlwiz

if [ -d ".git/" ]; then
 # Git was initiated in a previous call, we can pull the sources

    sudo git pull

else
 # Git needs to be initiated

    sudo git clone $PathToRepository ./

fi
