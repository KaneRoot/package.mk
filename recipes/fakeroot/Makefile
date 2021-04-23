name = fakeroot
version = 1.25.3
release = 0
URL = http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_$(version).orig.tar.gz
url = "https://packages.debian.org/fakeroot"
arch="all"
license="GPL-3.0-or-later"

pkgdesc="Gives a fake root environment, useful for building packages as a non-privileged user"

patches != ls *.patch

dependencies = util-linux
build-dependencies = nasm linux-dev util-linux-dev

makedepends_build = libtool autoconf automake po4a
makedepends_host = libcap-dev acl-dev linux-headers
makedepends = $(makedepends_build) $(makedepends_host)

CONFIG_SHELL = /bin/sh  
export CONFIG_SHELL

CONFIGURE_OPTIONS_USER = --build=$(CBUILD) --host=$(CHOST)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

ifeq ($(CLIBC), musl)
# musl does not have _STAT_VER, it's really not used for
# anything, so define it as zero (just like uclibc does)
CFLAGS = "-D_STAT_VER=0 $(CFLAGS)"
endif

pre_configure:
	$(Q)cd $(bdir) && ./bootstrap

pre_fake_root_install:
	$(Q)cd $(bdir)/doc && po4a -k 0 --rm-backups --variable "srcdir=../doc/" po4a/po4a.cfg
