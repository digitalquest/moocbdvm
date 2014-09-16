#!/bin/bash

set -x

# That won't do : should be run at final provisioning time, for user's vagrant up, not here at build time
# Create the directory. Could be replaced with a custom directory
#mkdir -p /vagrant/TP
# Change permissions
#chown -R vagrant:vagrant /vagrant/TP
#
# => Instead, see what is done at final provisionning
# (../../distrib/Vagrantfile and associate maj-maj.sh checked out from
# repo at
# http://fusionforge.int-evry.fr/anonscm/git/moocbdvm/update-scripts.git
# (see installation during provisionning.sh done in /usr/local/bin/)

# Create tp.conf in sites-available with the configuration lines for apache to take it into account
cat >/etc/apache2/sites-available/tp.conf <<EOF
Alias /TP /vagrant/TP

<Directory /vagrant/TP>
  Options Indexes FollowSymLinks
  AllowOverride None
  Require all granted
</Directory>

EOF

a2ensite tp
