name = elfutils
version = 0.183
release = 0
URL = https://sourceware.org/elfutils/ftp/$(version)/elfutils-$(version).tar.bz2

dependencies = argp-standalone fts
build-dependencies = musl-obstack-dev musl-libintl

#
# TODO: this recipe doesn't compile (missing the 'error.h' header)
#

CC=gcc

CONFIGURE_OPTIONS_USER = --target=$(ARCH)-baguette-linux-musl \
	--build=$(ARCH)-baguette-linux-musl \
	--host=$(ARCH)-baguette-linux-musl \
	--disable-libdebuginfod --disable-debuginfod

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
