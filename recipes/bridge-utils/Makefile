name = bridge-utils
version = 1.7
release = 0
pkgdesc = "Tools for configuring the Linux kernel 802.1d Ethernet Bridge"
source = "https://wiki.linuxfoundation.org/networking/bridge/"
arch = "all"
license = "GPL-2.0-or-later"
build-dependencies = autoconf linux-headers

URL = https://kernel.org/pub/linux/kernel/people/shemminger/$(name)/$(name)-$(version).tar.xz

CONFIGURE_OPTIONS_USER = --mandir=$(MANDIR) \
		--libdir=$(LIBDIR) \
		--includedir=$(INCLUDEDIR)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	cd $(bdir) ; autoconf
