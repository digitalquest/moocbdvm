Provisioning correspond au travail sur le provisionnement d'une box de
base données.

Plusieurs étapes :
 1. fabrication des box debian jessie de base
 2. fabrication des box pour le MOOC BD
 3. Publication des box pour utilisation


Fabrication de la box Debian Jessie de base
-------------------------------------------

A faire une fois de temps en temps pour refaire une image Debian
testing mise-à-jour, à publier dans
oberger/debianjessiemini-[amd64|i686] sur vagrantcloud.

Utilisation de bootstrap-vz avec le fichier manifest ad-hoc.

Cf. le README dans le répertoire 'DebianJessieBaseBox' pour plus de
détails.

Fabrication de la box du MOOC
-----------------------------
A refaire à chaque nouvelle version de la box du MOOC

Toutes :
 $ make boxes

ou version 64 bits seulement :
 $ make box

ou version 32 bits seulement:
 $ make box32

Uploader les image, puis nettoyer :

$ cd Provisionning; vagrant destroy

Version utilisée : Vagrant 1.6.3 (package Debian non officiel d'upstream).

Publication de la box
---------------------
Publication sur vagrantcloud (sur oberger/moocbdvm par exemple).

Par exemple stockée dans partage.mines-telecom.fr et référencée depuis
vagrantcloud.

TODO: Renseigner le MD5sum pour éviter des problèmes de transferts

Documentation
-------------

Documentation utilisateur initiale : TLDR.[org|html]

Cf. manuel.org pour plus de documentation.

Scripts de mises-à-jour
-----------------------

Un deuxième repository (public) est utilisé dans le projet fusionforge:
git+ssh://...@fusionforge.int-evry.fr//var/lib/gforge/chroot/scmrepos/git/moocbdvm/update-scripts.git
il contient les scripts qui seront téléchargés, par git, via les
scripts de mise-à-jour de la VM (maj-maj.sh etc.), via un git pull sur
http://fusionforge.int-evry.fr/anonscm/git/moocbdvm/update-scripts.git

