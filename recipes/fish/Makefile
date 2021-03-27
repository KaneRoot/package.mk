name = fish
version = 3.2.1
URL = https://github.com/fish-shell/fish-shell/releases/download/$(version)/fish-$(version).tar.xz

# OLD
#CONFIGURE_OPTIONS_USER = --without-gettext LIBS="-lncursesw"

CMAKE_OPTIONS = -DCMAKE_INSTALL_PREFIX=$(PREFIX) -DCMAKE_BUILD_TYPE=Release

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
