#!bin/bash

#FIXME
#cd .... ???

# TODO change this for appropriate dir
PathToRepository=http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git

if [ -d ".git/" ]; then
 # Git was initiated in a previous call, we can pull the sources

    git pull

else
# Git needs to be initiated

    git clone $PathToRepository ./

# Create aliases to ease the use of the scripts
    cat "alias update-site='maj-site.sh'" >> ~/.bashrc
    cat "alias update-tp='maj-tp.sh'" >> ~/.bashrc
    cat "alias update-script='maj-maj.sh'" >> ~/.bashrc

fi

cp maj-maj.sh /usr/locale/bin/
cp maj-site.sh /usr/locale/bin/
cp maj-tp.sh /usr/locale/bin/

# FIXME : ???
#c
