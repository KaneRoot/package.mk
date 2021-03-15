name = linux
version = 5.11
URL = https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$(version).tar.xz

build-dependencies = flex bison perl

dependencies = binutils

# WARNING: this has to be the same environment variables used
#          during the creation of the config file
MAKE_OPTIONS_USER = CC=clang \
	LD=ld.lld \
	AR=llvm-ar \
	NM=llvm-nm \
	STRIP=llvm-strip \
	OBJCOPY=llvm-objcopy \
	OBJDUMP=llvm-objdump \
	READELF=llvm-readelf \
	HOSTCC=clang \
	HOSTCXX=clang++ \
	HOSTAR=llvm-ar \
	HOSTLD=ld.lld


SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	$(Q)cd $(bdir) && make mrproper
	$(Q)cp config $(bdir)/.config

fake_root_install:
	@mkdir -p '$(pkg_fake_root_dir)/$(PREFIX)' '$(pkg_fake_root_dir)/boot'

	@# $(pkg_fake_root_dir)/boot: main package (kernel, vm and config)
	$(Q)cp $(bdir)/arch/x86/boot/bzImage $(pkg_fake_root_dir)/boot/linux-$(version)
	$(Q)cp $(bdir)/vmlinux $(pkg_fake_root_dir)/boot/vmlinux-$(version)
	$(Q)cp config $(pkg_fake_root_dir)/boot/linux-$(version).cfg

	@# $(pkg_fake_root_dir)/$(PREFIX): -dev split (headers).
	$(Q)cd $(bdir) && make headers_install ARCH=x86_64 INSTALL_HDR_PATH='$(pkg_fake_root_dir)/$(PREFIX)'

