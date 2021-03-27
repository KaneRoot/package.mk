name = libexecinfo
version = 1.1

URL = http://distcache.freebsd.org/local-distfiles/itetcu/libexecinfo-$(version).tar.bz2
patches = 10-execinfo.patch 20-define-gnu-source.patch 30-linux-makefile.patch

fake_root_install_backend = fake_root_install_custom

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

CFLAGS += -fno-omit-frame-pointer
export CFLAGS

fake_root_install_custom:
	install -D -m755 $(bdir)/execinfo.h       $(pkg_fake_root_dir)/$(PREFIX)/include/execinfo.h
	install -D -m755 $(bdir)/stacktraverse.h  $(pkg_fake_root_dir)/$(PREFIX)/include/stacktraverse.h
	install -D -m755 $(bdir)/libexecinfo.a    $(pkg_fake_root_dir)/$(PREFIX)/lib/libexecinfo.a
	install -D -m755 $(bdir)/libexecinfo.so.1 $(pkg_fake_root_dir)/$(PREFIX)/lib/libexecinfo.so.1
	ln -s $(PREFIX)/lib/libexecinfo.so.1      $(pkg_fake_root_dir)/$(PREFIX)/lib/libexecinfo.so
