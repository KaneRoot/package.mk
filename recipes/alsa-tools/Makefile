name = alsa-tools
version = 1.2.2
URL = ftp://ftp.alsa-project.org/pub/tools/alsa-tools-$(version).tar.bz2

description = "alsa-tools contains various obscure tools and loaders."

build-dependencies = alsa-lib-dev

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure:
	cd $(bdir) && make configure
