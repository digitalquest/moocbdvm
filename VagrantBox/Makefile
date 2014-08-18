date := $(shell date +%Y%m%d%H%M)
topdir := moocbdvm-vagrantbox-$(date)
# architecture of the VM
arch = amd64
#arch = i686
# argument passed to vagrant up (if needed - see Vagrantfile)
vagruparg=bits64
#vagruparg=bits32
boxname := moocbdvm-vagrantbox-$(arch)-$(date)
archive = $(topdir)

boxes: box box32

box32:
	$(MAKE) box arch=i686 vagruparg=bits32 date=$(date)

vm:	site tp
	cd Provisionning; vagrant up $(vagruparg)

site:
	cp manuel.html Provisionning/site/index.html
	cp TLDR.html Provisionning/site/

tp:
	cd Provisionning; \
	rm -fr TP; \
	mkdir TP; \
	cd TP; \
	git clone http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git ./

box:	vm
	cd Provisionning; \
	vagrant package --output $(boxname).box --vagrantfile ../distrib/Vagrantfile $(vagruparg) ; \
	vagrant destroy --force
	#cd Provisionning; md5sum $(boxname).box > $(boxname)_box.md5

dist:	
	rm -f $(archive).zip $(archive).tgz
	$(MAKE) archive=$(archive) $(archive).zip

$(archive).tgz:
	tar --transform s/Provisionning/$(topdir)/ --exclude='Provisionning/.vagrant' -zcvf $(archive).tgz Provisionning/

$(archive).zip:	$(archive).tgz
	tar zxf $<
	zip -r $@ $(archive)
	$(RM) -r $(archive)
