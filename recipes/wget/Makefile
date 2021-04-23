name = wget
version = 1.21.1
release = 0
pkgdesc = "Network utility to retrieve files from the Web"
url = "https://www.gnu.org/software/wget/wget.html"
arch = "all"
license = "GPL-3.0-or-later WITH OpenSSL-Exception"
build-dependencies = libidn2-dev openssl-dev perl
checkdepends = perl-http-daemon
subpackages = "$pkgname-doc"
URL = https://ftp.gnu.org/gnu/wget/wget-$(version).tar.gz

# secfixes:
#   1.20.3-r0:
#     - CVE-2019-5953
#   1.20.1-r0:
#     - CVE-2018-20483
#   1.19.5-r0:
#     - CVE-2018-0494
#   1.19.1-r1:
#     - CVE-2017-6508
#   1.19.2-r0:
#     - CVE-2017-13090

CONFIGURE_OPTIONS_USER = --sysconfdir=/etc \
		--mandir=$(MANDIR) \
		--infodir=$(PREFIX)/share/info \
		--with-libidn \
		--with-ssl=openssl \
		--disable-nls

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

post_fake_root_install:
	rm -rf "$(pkg_fake_root_dir)/usr/lib"
