name = file
version = 5.39
release = 0
URL = ftp://ftp.astron.com/pub/file/file-$(version).tar.gz

dependencies = zlib
build-dependencies = make, musl-dev, zlib-dev

CONFIGURE_OPTIONS_USER = --enable-zlib --disable-libseccomp

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
