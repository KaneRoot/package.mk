# Maintainer: Natanael Copa <ncopa@alpinelinux.org>
name = musl-obstack
version = 1.2.2
release = 0
pkgdesc = "Standalone library to implement GNU libc's obstack"
url = "https://github.com/void-linux/musl-obstack"
arch = "all"
license = "LGPL-2.1-or-later"
build-dependencies = automake autoconf libtool

URL = https://github.com/void-linux/musl-obstack/archive/v$(version).tar.gz

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	$(Q)cd $(bdir) ; ./bootstrap.sh
