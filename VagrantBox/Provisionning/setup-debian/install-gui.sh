#!/bin/sh

#set -x

yes=-y

apt-get install $yes --no-install-recommends virtualbox-guest-x11

apt-get install $yes --no-install-recommends lightdm xserver-xorg

#apt-get install $yes --no-install-recommends task-xfce-desktop task-french-desktop
aptitude install $yes -R task-xfce-desktop task-french-desktop

aptitude install $yes -R tango-icon-theme xfce4-xkb-plugin

aptitude install $yes -R xfce4-power-manager xfce4-terminal 

aptitude install $yes -R midori evince-gtk gedit

# xfce4-xkb-plugin dans barre d'outils

# /vagrant en raccourci sur le bureau et en raccourci dans le gestionnaire de fichiers

# Doc sans :8080 dans la VM

# pointeur sur file:///usr/share/doc/midori/faq.html dans la doc ?

# page par défaut de midori sur http://localhost/

# icône lien URL sur bureau -> http://localhost/

# /etc/lightdm/lightdm-gtk-greeter.conf -> supprimer ~power de show-indicators=

# auto-login lightdm dans /etc/lightdm/lightdm.conf :
# [SeatDefaults]
# autologin-user=vagrant
# autologin-user-timeout=0

apt-get clean

service lightdm restart
