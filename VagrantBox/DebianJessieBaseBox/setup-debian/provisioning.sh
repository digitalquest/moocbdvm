#!/bin/bash

#download_url=http://www-tp.int-evry.fr/~germai_s/
debian_mirror=http://ftp.fr.debian.org

echo "Provisioning the VM"

# Debug mode
set -x

# Update the guest OS packages
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
export DEBCONF_NOWARNINGS=yes
export LANG=C

mv /etc/apt/sources.list /etc/apt/sources.list.bak

cat >/etc/apt/sources.list <<EOF
deb $debian_mirror/debian jessie main contrib non-free
deb-src $debian_mirror/debian jessie main contrib non-free 

deb http://security.debian.org/ jessie/updates main contrib non-free
deb-src http://security.debian.org/ jessie/updates main contrib non-free 

# jessie-updates, previously known as 'volatile'
deb $debian_mirror/debian jessie-updates main contrib non-free
deb-src $debian_mirror/debian jessie-updates main contrib non-free
EOF

apt-get update -q -q

# installed=$(apt-cache policy linux-image-amd64 | grep 'Installed:' | sed 's/.*Installed: //g')
# candidate=$(apt-cache policy linux-image-amd64 | grep 'Candidate:' | sed 's/.*Candidate: //g')
# echo "installed: $installed"
# echo "candidate: $candidate"

# if [ "$installed" != "$candidate" ]; then
#     apt-get install --yes virtualbox-guest-utils linux-headers-amd64 linux-image-amd64 

#     # reboot new kernel
#     # May need https://github.com/exratione/vagrant-provision-reboot

#     # Then ...
# fi
# exit 0

#apt-get install --reinstall virtualbox-guest-dkms

apt-get install --yes virtualbox-guest-utils linux-headers-amd64 linux-image-amd64 

apt-get dist-upgrade -q --yes --force-yes


apt-get clean
