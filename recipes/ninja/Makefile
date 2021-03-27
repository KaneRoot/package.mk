name = ninja
version = 1.9.0
#version = 1.10.2
URL = https://github.com/ninja-build/ninja/archive/v$(version).tar.gz

# https://git.alpinelinux.org/aports/tree/unmaintained/ninja
patches = musl.patch

build-dependencies = python

configure_backend = configure_custom
configure_custom:
	$(Q)cd $(bdir); ./configure.py --bootstrap

fake_root_install_backend = fake_root_install_custom
fake_root_install_custom:
	cd $(bdir); install -Dm755 ninja $(pkg_fake_root_dir)/$(PREFIX)/bin/ninja

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
