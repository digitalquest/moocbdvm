#!/bin/bash

#download_url=http://www-tp.int-evry.fr/~germai_s/
#debian_mirror=http://ftp.fr.debian.org

pathToSetupTp="/vagrant/setup-debian/"   

echo "Provisioning the VM"

# Debug mode
set -x

# Update the guest OS packages
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
export DEBCONF_NOWARNINGS=yes
export LANG=C

# mv /etc/apt/sources.list /etc/apt/sources.list.bak

# cat >/etc/apt/sources.list <<EOF
# deb $debian_mirror/debian jessie main contrib non-free
# deb-src $debian_mirror/debian jessie main contrib non-free 

# deb http://security.debian.org/ jessie/updates main contrib non-free
# deb-src http://security.debian.org/ jessie/updates main contrib non-free 

# # jessie-updates, previously known as 'volatile'
# deb $debian_mirror/debian jessie-updates main contrib non-free
# deb-src $debian_mirror/debian jessie-updates main contrib non-free
# EOF

apt-get update -q -q

apt-get dist-upgrade -q --yes --force-yes

# Install Apache web server, PGSQL, PHP, JS, Git
echo ".installing needed applications"
apt-get install -q -y apache2 php5 postgresql libapache2-mod-php5 php5-pgsql javascript-common phppgadmin git-core

apt-get clean

# Fetch the SQL scripts (acces: ssh germai_s@ssh)
# wget http://www-tp/~germai_s/script-vins.sql .
# wget http://www-tp/~germai_s/script-film.sql .
# wget http://www-tp/~germai_s/execpostgres.php .
# wget http://www-tp/~germai_s/interp.html .

# Create and mange the databases
cd /vagrant/setup-debian

sudo -u postgres psql -f setup.sql


# Get the path to pg_hba.conf
sudo -u postgres psql -c "SHOW hba_file" > config.txt

PathToConf=$(grep '/[a-z]*' config.txt)  

# Change authentification method from ident to trust
sed -ire 's/local [ \t]*all [ \t]*all [ \t]*peer/local all all trust/' $PathToConf

# Cleaning-up
rm config.txt

# Tell apache to read from conf.d
# sed -i '$a\Include conf.d/' > /etc/apache2/apache2.conf
ln -s /etc/apache2/conf.d/phppgadmin /etc/apache2/conf-enabled/phppgadmin.conf

# Change permission to access phppgadmin from all
sed -ire 's/deny from all/# deny from all/' /etc/apache2/conf.d/phppgadmin
sed -ire 's/allow from 127.0.0.0/# allow from 127.0.0.0/' /etc/apache2/conf.d/phppgadmin
sed -ire 's/# allow from all/allow from all/' /etc/apache2/conf.d/phppgadmin

# Clone the git repository for the provided website
git clone http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git /var/www/html/bdsqlwiz

# Launch the sheel script used allow the user to use his own php pages. Not finished yet
chmod a+x $pathToSetupTp"setup-tp.sh"
sh $pathToSetupTp"setup-tp.sh"

# Restart postgresql services
/etc/init.d/postgresql reload


cp -r /vagrant/appli /var/www/html/

cd /var/www/html/
mv index.html index.html.old
cp /vagrant/site/index.html ./

# Restart apache server
/etc/init.d/apache2 restart 

