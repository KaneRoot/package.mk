name = openssl
version = 1.1.1k
URL = https://www.openssl.org/source/openssl-$(version).tar.gz

configure_backend = configure_custom
configure_custom:
	cd $(bdir) && ./Configure --prefix=$(PREFIX) linux-$(ARCH)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
