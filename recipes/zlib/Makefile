name = zlib
version = 1.2.11
release = 0
URL = https://www.zlib.net/zlib-$(version).tar.gz

# zlib doesn't accept invalid options.
# We have to force valid ones.
CONFIGURE_OPTIONS = --prefix=$(PREFIX)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure_cmake:
	@true
