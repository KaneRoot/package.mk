name = ncurses
version = 6.2
release = 0
URL = ftp://ftp.invisible-island.net/ncurses/ncurses-$(version).tar.gz

CONFIGURE_OPTIONS_USER = --enable-widec --without-ada --with-shared --enable-pc-files --disable-termcap
MAKE_OPTIONS = DESTDIR=$(pkg_fake_root_dir)/
MAKE_INSTALL_OPTIONS_USER = DESTDIR=$(pkg_fake_root_dir)/


SYSCONF ?= ../../
include $(SYSCONF)/package.mk

post_fake_root_install:
	rm $(pkg_fake_root_dir)/$(PREFIX)/bin/clear
	rm $(pkg_fake_root_dir)/$(PREFIX)/bin/reset
