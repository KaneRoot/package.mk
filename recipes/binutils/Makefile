name = binutils
version = 2.36
release = 0
URL = https://ftp.gnu.org/gnu/binutils/binutils-$(version).tar.xz

dependencies = flex

CONFIGURE_OPTIONS_USER = --disable-multilib --with-pic --disable-nls
MAKE_OPTIONS_USER = tooldir=$(PREFIX)
MAKE_INSTALL_OPTIONS_USER = tooldir=$(PREFIX)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

# Not sure why.
post_fake_root_install:
	rm $(pkg_fake_root_dir)/$(PREFIX)/bin/strings

.PHONY: # all  clean distclean dist install uninstall help
