date := $(shell date +%Y%m%d%H%M)
topdir := moocbdvm-vagrantbox-$(date)
archive = $(topdir)

vm:	site tp
	cd Provisionning; vagrant up

site:
	cp manuel.html Provisionning/site/index.html

tp:
	cd Provisionning; \
	rm -fr TP; \
	mkdir TP; \
	cd TP; \
	git clone http://fusionforge.int-evry.fr/anonscm/git/bdsqlwiz/bdsqlwiz.git ./

box:
	cd Provisionning; vagrant package --output $(topdir).box --include appli --vagrantfile ../distrib/Vagrantfile default
	cd Provisionning; md5sum $(topdir).box > $(topdir)_box.md5

dist:	
	rm -f $(archive).zip $(archive).tgz
	$(MAKE) archive=$(archive) $(archive).zip

$(archive).tgz:
	tar --transform s/Provisionning/$(topdir)/ --exclude='Provisionning/.vagrant' -zcvf $(archive).tgz Provisionning/

$(archive).zip:	$(archive).tgz
	tar zxf $<
	zip -r $@ $(archive)
	$(RM) -r $(archive)
