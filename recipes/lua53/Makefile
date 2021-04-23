name = lua53
version = 5.3.6
URL = https://www.lua.org/ftp/lua-$(version).tar.gz

build-dependencies = readline-dev

MAKE_OPTIONS_USER = LDFLAGS=-lncursesw linux DESTDIR=$(pkg_fake_root_dir)
MAKE_INSTALL_OPTIONS_USER = INSTALL_TOP=$(pkg_fake_root_dir)/$(PREFIX) \
	INSTALL_MAN=$(pkg_fake_root_dir)/$(PREFIX)/share/man/man1

pkg_build_dir = $(pkg_build_par_dir)/lua-$(version)/

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
