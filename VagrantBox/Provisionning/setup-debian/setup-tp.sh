#!/bin/bash

set -x

# Create the directory. Could be replaced with a custom directory
mkdir -p /vagrant/TP

# Change permissions
chown -R vagrant:vagrant /vagrant/TP

# Create tp.conf in sites-available with the configuration lines for apache to take it into account
# touch /etc/apache2/sites-available/tp.conf
# echo "Alias /TP /vagrant/TP" > /etc/apache2/sites-available/tp.conf
# echo "<Directory /vagrant/TP>" >> /etc/apache2/sites-available/tp.conf
# echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/tp.conf
# echo "AllowOverride None" >> /etc/apache2/sites-available/tp.conf
# echo "Require all granted" >> /etc/apache2/sites-available/tp.conf
# echo "</Directory>" >> /etc/apache2/sites-available/tp.conf
cat >/etc/apache2/sites-available/tp.conf <<EOF
Alias /TP /vagrant/TP

<Directory /vagrant/TP>
  Options Indexes FollowSymLinks
  AllowOverride None
  Require all granted
</Directory>

EOF

a2ensite tp
