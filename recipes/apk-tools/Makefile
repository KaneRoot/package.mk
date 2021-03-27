name = apk-tools
version = 2.10.5
release = 0
URL = https://dev.alpinelinux.org/archive/apk-tools/apk-tools-$(version).tar.xz

build-dependencies = lua5.3-dev

MAKE_OPTIONS_USER = LUAAPK=static

# FIXME: these directories are removed during packaging.

install:
	mkdir -p '$(pkg_fake_root_dir)/sbin'
	cp $(bdir)/src/apk.static '$(pkg_fake_root_dir)/sbin/apk'
	mkdir -p '$(pkg_fake_root_dir)/var/lib/apk'
	mkdir -p '$(pkg_fake_root_dir)/var/cache/misc'
	mkdir -p '$(pkg_fake_root_dir)/etc/apk/keys'
	mkdir -p '$(pkg_fake_root_dir)/etc/apk/protected_paths.d'


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
