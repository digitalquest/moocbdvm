#!/bin/bash

# Create the directory. Could be replaced with a custom directory
mkdir /vagrant/TP

# Change permissions
chown -R vagrant:vagrant /vagrant/TP

# Edit the /etc/apache2/sites-available/000-default.conf file to make an alias
touch /etc/apache2/sites-available/tp.conf
sed -i 'Alias /TP /vagrant/TP
<Directory /vagrant/TP>
	Options Indexes FollowSymLinks MultiViews
	AllowOverride All
	Require all granted
</Directory>' > /etc/apache2/sites-available/tp.conf
