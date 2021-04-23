name = busybox
version = 1.33.0
release = 0
URL = https://busybox.net/downloads/busybox-$(version).tar.bz2

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure:
	cd $(bdir) ; \
	make defconfig ; \
	sed -e 's/.*CONFIG_STATIC.*/CONFIG_STATIC=y/' .config > config-new ; \
	mv config-new .config

fake_root_install:
	mkdir -p '$(pkg_fake_root_dir)/bin'
	mkdir -p '$(pkg_fake_root_dir)/sbin'
	mkdir -p '$(pkg_fake_root_dir)/usr/bin'
	mkdir -p '$(pkg_fake_root_dir)/usr/sbin'
	cp $(bdir)/busybox '$(pkg_fake_root_dir)/bin/busybox'
	chroot '$(pkg_fake_root_dir)' /bin/busybox --install -s
	mv '$(pkg_fake_root_dir)/usr/sbin/killall5' '$(pkg_fake_root_dir)/sbin/'
