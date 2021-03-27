name = zshrc
version = 0.0.1
URL =

simple_copy: create_fake_root_dir
	mkdir -p '$(pkg_fake_root_dir)/etc/zsh'
	cp zshrc '$(pkg_fake_root_dir)/etc/zshrc'
	cp *.zsh '$(pkg_fake_root_dir)/etc/zsh/'

# Removing all backends, there is no download and no build.
# Just a simple file copy.
download_backend =
configure_backend = simple_copy
build_backend =
fake_root_install_backend =

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
