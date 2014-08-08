date := $(shell date +%Y%m%d%H%M)
boxpackage = debianjessiebase-$(date).box

all:	vm box

vm:
	vagrant up
	# then reboot it
	vagrant reload

box:
	vagrant package --output $(boxpackage) default
