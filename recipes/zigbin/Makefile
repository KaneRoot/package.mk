name = zigbin
version = 0.7.1
URL = https://ziglang.org/download/0.7.1/zig-linux-$(ARCH)-$(version).tar.xz

pkg_build_dir = $(pkg_working_dir)/build/zig-linux-$(ARCH)-$(version)/

configure_backend =
build_backend = 
# FIXME: lib in /bin/
fake_root_install_backend = fake_root_install_custom

# Splits are removed, no need for this recipe.
base: create_repository_dir package_base
create_steps = build-env configure build fake_root_install base clean_working_dir

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

fake_root_install_custom:
	@echo -e "\033[0;34;47m>> install zig binary from ziglang\033[0m"
	$(Q)mkdir -p $(pkg_fake_root_dir)/$(PREFIX)/bin
	$(Q)cp    $(bdir)/zig $(pkg_fake_root_dir)/$(PREFIX)/bin/
	$(Q)cp -r $(bdir)/lib $(pkg_fake_root_dir)/$(PREFIX)/bin/
