name = bzip2
version = 1.0.6
release = 0
URL = https://downloads.sourceforge.net/project/bzip2/bzip2-$(version).tar.gz

MAKE_INSTALL_OPTIONS_USER = PREFIX=$(pkg_fake_root_dir)/$(PREFIX)

pre_configure:
	$(Q)sed -i.orig -e '/^CFLAGS=/s/.*/CFLAGS = -O2 -fPIC/' $(bdir)/Makefile


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
