Provisioning correspond au travail sur le provisionnement d'une box de
base données.

Plusieurs étapes :
 1. fabrication de la box debian jessie de base
 2. fabrication de la box pour le MOOC BD
 3. Publication de la box pour utilisation


Fabrication de la box Debian Jessie de base
-------------------------------------------

A faire une fois de temps en temps pour refaire une image Debian
testing mise-à-jour, à publier dans oberger/debianjessiemini sur
vagrantcloud.

Utilisation de bootstrap-vz avec le fichier manifest ad-hoc.

Cf. le README dans le répertoire DebianJessieBaseBox pour plus de
détails.

Fabrication de la box du MOOC
-----------------------------
A refaire à chaque nouvelle version de la box du MOOC

$ make vm
$ make box

Uploader l'image, puis nettoyer :

$ cd Provisionning; vagrant destroy


Publication de la box
---------------------
Publication sur vagrantcloud (sur oberger/moocbdvm par exemple).

Par exemple stockée dans partage.mines-telecom.fr et référencée depuis
vagrantcloud.

TODO: Renseigner le MD5sum pour éviter des problèmes de transferts


Cf. manuel.org pour plus de documentation.

