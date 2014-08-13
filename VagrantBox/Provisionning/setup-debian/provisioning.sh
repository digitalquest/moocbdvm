#!/bin/bash

#download_url=http://www-tp.int-evry.fr/~germai_s/
debian_mirror=http://ftp.fr.debian.org

pathToSetupTp=/vagrant/setup-debian

echo "Provisioning the VM"

# Debug mode
set -x

# Update the guest OS packages
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
export DEBCONF_NOWARNINGS=yes
export LANG=C

mv /etc/apt/sources.list /etc/apt/sources.list.bak

# We'll do apt pinning in order to install postgresql-common and
# postgresql-client-common version >= 160 from unstable
# to fix bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=757612 present in testing until 2014/08/16
# See COMMENT_ME below

cat >/etc/apt/sources.list <<EOF
deb $debian_mirror/debian jessie main contrib non-free
deb-src $debian_mirror/debian jessie main contrib non-free 

deb http://security.debian.org/ jessie/updates main contrib non-free
deb-src http://security.debian.org/ jessie/updates main contrib non-free 

# jessie-updates, previously known as 'volatile'
deb $debian_mirror/debian jessie-updates main contrib non-free
deb-src $debian_mirror/debian jessie-updates main contrib non-free
EOF

# COMMENT_ME comment-out the following after 2014/08/16 (see above)
cat > /etc/apt/sources.list.d/unstable.list <<EOF
deb http://ftp.fr.debian.org/debian unstable main contrib non-free
EOF

# COMMENT_ME comment-out the following after 2014/08/16 (see above)
echo 'APT::Default-Release "jessie";' > /etc/apt/apt.conf.d/jessie

# COMMENT_ME comment-out the following after 2014/08/16 (see above)
cat > /etc/apt/preferences.d/pinning-unstable-postgresql <<EOF
Package: *
Pin: release a=jessie
Pin-Priority: 900

Package: postgresql-common postgresql-client-common
Pin: release a=unstable
Pin-Priority: 800

EOF

apt-get update -q -q

apt-get dist-upgrade -q --yes --force-yes

echo ".configuring french keyboard 'azerty' by default"

/vagrant/setup-debian/french-keyboard.sh

# Install Apache web server, PGSQL, PHP, JS, Git
echo ".installing needed applications"
# COMMENT_ME revert to the commented-out line below, after 2014/08/16 (see above)
# apt-get install -q -y apache2 php5 postgresql-common postgresql-client-common postgresql libapache2-mod-php5 php5-pgsql javascript-common phppgadmin git-core
apt-get install -q -y apache2 php5 postgresql-common/unstable postgresql-client-common/unstable postgresql libapache2-mod-php5 php5-pgsql javascript-common phppgadmin git-core

apt-get clean

# Set vagrant user's password to 'vagrant'
echo "vagrant:vagrant" | chpasswd

# Create and populate the databases
cd /vagrant/setup-debian

sudo -u postgres psql -f setup.sql

# Get the path to pg_hba.conf
sudo -u postgres psql -c "SHOW hba_file" > config.txt

PathToConf=$(grep '/[a-z]*' config.txt)  

# Change authentification method from ident to trust
sed -ire 's/local [ \t]*all [ \t]*all [ \t]*peer/local all all trust/' $PathToConf

# Cleaning-up
rm config.txt

# Set password for PostgreSQL user postgres to postgres (not postgres Unix user)
cd /tmp; sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';" postgres 

# Allow user postgres to connect to phppgadmin
sed -i 's/\(^.*conf\[.extra_login_security.\] =\) true/\1 false/' /etc/phppgadmin/config.inc.php

# Tell apache to read from conf.d
# sed -i '$a\Include conf.d/' > /etc/apache2/apache2.conf
ln -s /etc/apache2/conf.d/phppgadmin /etc/apache2/conf-enabled/phppgadmin.conf

# Change permission to access phppgadmin from all
sed -ire 's/deny from all/# deny from all/' /etc/apache2/conf.d/phppgadmin
sed -ire 's/allow from 127.0.0.0/# allow from 127.0.0.0/' /etc/apache2/conf.d/phppgadmin
sed -ire 's/# allow from all/allow from all/' /etc/apache2/conf.d/phppgadmin

# Restart postgresql services
/etc/init.d/postgresql reload


echo ".installing the labs applications"

# Clone the git repository for the provided website
git clone http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git /var/www/html/bdsqlwiz
sed -i "s/'test'/'pg_reader'/g" /var/www/html/bdsqlwiz/appli/execpostgres.php
sed -i 's/"whatever"/"tpinfint"/g' /var/www/html/bdsqlwiz/appli/execpostgres.php

# Launch the script to pull the update scripts, create aliases and move to /usr/local/bin/
#/vagrant/update/maj-maj.sh

# Launch the shell script used allow the user to use his own php pages. Not finished yet
$pathToSetupTp/setup-tp.sh

cd /var/www/html/
mv index.html index.html.old
cp /vagrant/site/index.html ./

# Make it so apache listens to 8080 inside the VM too, so the docs links are valid there too
echo "Listen 8080" >> /etc/apache2/ports.conf

# Restart apache server
service apache2 restart 

cp $pathToSetupTp/install-gui.sh /usr/local/sbin/

# Copy XFCE4 settings to the user's home
cp -r /vagrant/vagrant_user_config ~vagrant/.config
chown -R vagrant:vagrant ~vagrant/.config

# Copy the links on the user's Desktop to its home
cp -r /vagrant/vagrant_user_Desktop ~vagrant/Desktop
chown -R vagrant:vagrant ~vagrant/Desktop

