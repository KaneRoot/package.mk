name = sysvinit
version = 2.99
URL = https://git.savannah.nongnu.org/cgit/sysvinit.git/snapshot/sysvinit-$(version).tar.gz
dependencies = util-linux

fake_root_install_backend = fake_root_install_custom
fake_root_install_custom:
	cd $(bdir) && make ROOT='$(pkg_fake_root_dir)' install


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
