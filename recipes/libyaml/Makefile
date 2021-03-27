name = libyaml
version = 0.2.5
URL = https://github.com/yaml/libyaml/archive/$(version).tar.gz

CONFIGURE_OPTIONS_USER = --enable-static

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	cd $(bdir) && ./bootstrap
