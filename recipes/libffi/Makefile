name = libffi
version = 3.3
URL = ftp://sourceware.org/pub/libffi/libffi-$(version).tar.gz

post_fake_root_install:
	mv $(pkg_fake_root_dir)/$(PREFIX)/lib/libffi-$(version)/include $(pkg_fake_root_dir)/$(PREFIX)/
	rm -rf $(pkg_fake_root_dir)/$(PREFIX)/lib/libffi-$(version)


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
