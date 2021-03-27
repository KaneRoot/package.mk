name = vim
version = 8.2.2650
URL = https://github.com/$(name)/$(name)/archive/v$(version).tar.gz

description = Improved vi-style text editor
license = charityware
url = https://www.vim.org

packager = Mickaël Bauer <mickael.bauer7@gmail.com>
dependencies = ncurses

CONFIGURE_OPTIONS_USER = --with-tlib=ncursesw

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

post_fake_root_install:
	rm $(pkg_fake_root_dir)/$(PREFIX)/bin/xxd
