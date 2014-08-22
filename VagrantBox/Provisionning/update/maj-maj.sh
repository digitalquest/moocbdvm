#!/bin/bash

# This script is a wrapper for the other update scripts. It is to be in /usr/local/bin/ and call the other scripts in a different directory

cd /vagrant/update/

git pull

cp maj-maj.sh /usr/local/bin/

sh update-scripts/update/maj-site.sh
sh update-scripts/update/maj-tp.sh
