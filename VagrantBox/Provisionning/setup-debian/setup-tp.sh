#!/bin/bash

# Create the directory. Could be replaced with a custom directory
mkdir /vagrant/TP

# Change permissions
chown -R vagrant:vagrant /vagrant/TP

# Create tp.conf in sites-available with the configuration lines for apache to take it into account
touch /etc/apache2/sites-available/tp.conf
echo "Alias /TP /vagrant/TP" > /etc/apache2/sites-available/tp.conf
echo "<Directory /vagrant/TP>" >> /etc/apache2/sites-available/tp.conf
echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/tp.conf
echo "AllowOverride None" >> /etc/apache2/sites-available/tp.conf
echo "Require all granted" >> /etc/apache2/sites-available/tp.conf
echo "</Directory>" >> /etc/apache2/sites-available/tp.conf

# Make a symlink in sites-enabled to enable the configuration file to be used
ln -s /etc/apache2/sites-available/tp.conf /etc/apache2/sites-enabled/tp.confx
 
