name = musl-fts
version = 1.2.7
URL = https://github.com/void-linux/musl-fts/archive/v$(version).tar.gz

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	cd $(bdir) ; ./bootstrap.sh
