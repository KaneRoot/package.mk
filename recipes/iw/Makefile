name = iw
version = 5.9
URL = https://www.kernel.org/pub/software/network/iw/iw-$(version).tar.xz

build-dependencies = libnl-dev

# prefix has to be provided through environment variables
configure_backend =

MAKE_INSTALL_OPTIONS_USER = PREFIX=$(PREFIX)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
