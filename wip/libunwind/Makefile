name = libunwind
version = 1.5.0
URL = https://download.savannah.nongnu.org/releases/libunwind/libunwind-$(version).tar.gz

description = "Portable and efficient C programming interface (API) to determine the call-chain of a program"
website = "https://www.nongnu.org/libunwind/"
license="MIT"

build-dependencies = autoconf automake libtool linux-headers xz-dev libucontext-dev

patches = force-enable-man.patch \
	musl-mips-fix.patch \
	ppc64-musl.patch \
	fix-ppc64-libdir.patch \
	fix-libunwind-pc-in.patch

pre_configure:
	@cd $(bdir) && autoreconf -fi


LDFLAGS = $(LDFLAGS) -lucontext
CFLAGS  = $(CFLAGS) -fno-stack-protector

CONFIGURE_OPTIONS_USER = --enable-cxx-exceptions

SYSCONF ?= ../../
include $(SYSCONF)/package.mk


