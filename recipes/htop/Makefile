# Contributor: Sören Tempel <soeren+alpine@soeren-tempel.net>
# Maintainer: Carlo Landmeter <clandmeter@alpinelinux.org>
name = htop
version = 3.0.5
release = 0
pkgdesc = "Interactive process viewer"
url = "https://htop.dev/"
arch = "all"
license = "GPL-2.0-or-later"
build-dependencies = ncurses-dev python3 autoconf automake linux-headers
options = "!check" # no upstream/available test-suite
URL = https://github.com/htop-dev/htop/archive/$(version).tar.gz

CONFIGURE_OPTIONS_USER = --sysconfdir=/etc \
		--mandir=$(MANDIR) \
		--localstatedir=/var \
		--enable-cgroup \
		--enable-taskstats

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	cd $(bdir) ; ./autogen.sh
