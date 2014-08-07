date := $(shell date +%Y%m%d%H%M)
topdir := moocbdvm-vagrantbox-$(date)
archive = $(topdir)

vm:
	cd Provisionning; vagrant up

box:
	cd Provisionning; vagrant package --output $(topdir).box --include appli default

dist:	
	rm -f $(archive).zip $(archive).tgz
	$(MAKE) archive=$(archive) $(archive).zip

$(archive).tgz:
	tar --transform s/Provisionning/$(topdir)/ --exclude='Provisionning/.vagrant' -zcvf $(archive).tgz Provisionning/

$(archive).zip:	$(archive).tgz
	tar zxf $<
	zip -r $@ $(archive)
	$(RM) -r $(archive)
