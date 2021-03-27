name = yash
version = 2.51
URL = https://github.com/magicant/yash/releases/download/$(version)/yash-$(version).tar.gz

CONFIGURE_OPTIONS = --prefix=$(PREFIX) CFLAGS="-O2 -fPIC -D_POSIX_C_SOURCE"

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
