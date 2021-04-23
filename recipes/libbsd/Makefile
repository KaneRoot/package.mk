name = libbsd
version = 0.10.0
pkgrel = 0
pkgdesc = "commonly-used BSD functions not implemented by all libcs"
url = "https://libbsd.freedesktop.org/"
arch = "all"
license = "BSD"
dependencies = "musl>=1.1.16-r22"
build-dependencies = bsd-compat-headers linux-headers
build-dependencies += autoconf automake libtool
URL = https://libbsd.freedesktop.org/releases/$(name)-$(version).tar.xz

patches = disable-fpurge-test.patch

# secfixes:
#   0.10.0-r0:
#     - CVE-2019-20367

CONFIGURE_OPTIONS_USER = --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=$(MANDIR) \
		--infodir=$(SHAREDIR)/info \
		--localstatedir=/var

MAKE_INSTALL_OPTIONS_USER = -C "$(bdir)"

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	cd $(bdir) ; autoreconf -fi
