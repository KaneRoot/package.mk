
name    = xz
version = 5.2.5
URL = https://tukaani.org/xz/xz-$(version).tar.xz

patches =
conflicts =

SYSCONF ?= ../../

include $(SYSCONF)/package.mk

# for test purposes
pre_configure:
	@echo "PRECONFIGURATON OVERRIDE"

.PHONY: # all  clean distclean dist install uninstall help
