#!/bin/sh

set -x
cat >/etc/default/keyboard <<EOF

# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="fr"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"

EOF

debconf-set-selections /vagrant/setup-debian/keymap-preseed.conf

apt-get install -q -y keyboard-configuration
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true dpkg-reconfigure keyboard-configuration

apt-get install -q -y console-data
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true dpkg-reconfigure console-data

apt-get install -q -y console-setup

