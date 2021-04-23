name = mtools
version = 4.0.26
release = 0

pkgdesc = "collection of utilities to access MS-DOS disks from Unix without mounting them"
url = "https://www.gnu.org/software/mtools/"
arch = "all"
license = "GPL-3.0-or-later"
build-dependencies = texinfo linux-headers
URL = "https://ftp.gnu.org/gnu/mtools/mtools-$(version).tar.bz2"
subpackages = $(name)-doc

CONFIGURE_OPTIONS_USER = --mandir=$(MANDIR) \
		--infodir=$(SHAREDIR)/info \
		--sysconfdir=/etc/mtools \
		--without-x

MAKE_INSTALL_OPTIONS_USER = -j1

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
