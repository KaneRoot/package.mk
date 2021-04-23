name = syslinux
#version = 6.03
#URL = https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/$(name)-$(version).tar.gz
version_abbr = 6.04
version = $(version_abbr)-pre1
URL = https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/Testing/$(version_abbr)/syslinux-$(version).tar.xz

patches != ls *.patch

dependencies = util-linux
build-dependencies = nasm linux-dev util-linux-dev

loaderarch_ = efi64
ifeq ($(ARCH),x86)
loaderarch_ = efi32
endif
loaderarch ?= $(loaderarch_)

build_backend = build_custom
build_custom:
	$(Q)cd $(bdir); LDFLAGS= make $(loaderarch) installer

MAKE_INSTALL_OPTIONS_USER = -j1 \
	INSTALLROOT="$(pkg_fake_root_dir)" \
	DATADIR=$(PREFIX) \
	BINDIR=$(BINDIR) \
	SBINDIR=$(SBINDIR) \
	LIBDIR=$(LIBDIR) \
	INCDIR=$(INCLUDEDIR) \
	MANDIR=$(MANDIR) \
	TFTPBOOT=$(PREFIX)/tftpboot \
	bios $(loaderarch)

post_fake_root_install:
	mkdir -p "$(pkg_fake_root_dir)"/etc/update-extlinux.d
	cp update-extlinux.conf "$(pkg_fake_root_dir)"/etc/
	sed "/^version=/s/=.*/=$(version)-r$(release)/" update-extlinux \
		> "$(pkg_fake_root_dir)"/sbin/update-extlinux
	chmod 755 "$(pkg_fake_root_dir)"/sbin/update-extlinux

#build_custom:
#	cd $(bdir) ; \
#	(echo '#include <sys/sysmacros.h>'; cat extlinux/main.c) > main.c.new && \
#		mv main.c.new extlinux/main.c ; \
#	make efi32 efi64 bios installer

#MAKE_INSTALL_OPTIONS_USER = INSTALLROOT="$(pkg_fake_root_dir)" EXTLINUXDIR=/boot/extlinux

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
