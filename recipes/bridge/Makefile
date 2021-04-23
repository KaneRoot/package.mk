name = bridge
version = 1.5
url = "https://wiki.alpinelinux.org/wiki/Bridge"
pkgdesc = "Scripts for configuring network bridge interfaces"

dependencies = bridge-utils

create_steps = create_fake_root_dir fake_root_install_custom package_base clean_working_dir
fake_root_install_custom:
	install -Dm755 bridge.pre-up "$(pkg_fake_root_dir)"/etc/network/if-pre-up.d/bridge
	install -d "$(pkg_fake_root_dir)"/etc/network/if-post-down.d
	ln -s ../if-pre-up.d/bridge "$(pkg_fake_root_dir)"/etc/network/if-post-down.d/bridge

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
