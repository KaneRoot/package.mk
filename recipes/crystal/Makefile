name = crystal
version = 1.0.0
release = 0
URL = https://github.com/crystal-lang/crystal/archive/$(version).tar.gz

build-dependencies = llvm-10-dev
dependencies = libyaml libevent pcre llvm-10 libressl

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

build_custom:
	cd $(bdir) ; \
	make release=1 \
		FLAGS="--release --no-debug" \
		CRYSTAL_PATH="$(pwd)/src" \
		CRYSTAL_CONFIG_VERSION="$(version)" \
		CRYSTAL_CONFIG_PATH="lib:$(PREFIX)/lib/crystal" \
		CRYSTAL_CACHE_DIR="/tmp/crystal" \
		LLVM_CONFIG=$(PREFIX)/bin/llvm-config ; \
	make docs CRYSTAL_CACHE_DIR="$(TMP)/crystal"

fake_root_install_custom:
	@mkdir -p "$(pkg_fake_root_dir)/$(PREFIX)/bin"
	@mkdir -p "$(pkg_fake_root_dir)/$(PREFIX)/lib"
	@mkdir -p "$(pkg_fake_root_dir)/$(PREFIX)/share/man/man1"

	$(Q)install -m755 "$(bdir)/.build/crystal" "$(pkg_fake_root_dir)/$(PREFIX)/bin/crystal"

	$(Q)cp -r $(bdir)/src "$(pkg_fake_root_dir)/$(PREFIX)/lib/crystal"

	$(Q)rm -rf $(pkg_fake_root_dir)/$(PREFIX)/lib/crystal/ext/sigfault.*
	$(Q)rm -rf $(pkg_fake_root_dir)/$(PREFIX)/lib/crystal/llvm/ext/llvm_ext.o

	$(Q)mkdir -p "$(pkg_fake_root_dir)/$(PREFIX)/share/doc/crystal"
	$(Q)cp -r $(bdir)/docs "$(pkg_fake_root_dir)/$(PREFIX)/share/doc/crystal/api"
	$(Q)cp -r $(bdir)/samples "$(pkg_fake_root_dir)/$(PREFIX)/share/doc/crystal/"

	$(Q)install -m644 $(bdir)/man/crystal.1 "$(pkg_fake_root_dir)/$(PREFIX)/share/man/man1/"

	@# We’ll probably want those at some point… in due time, and in splits.
	@#install -m644 etc/completion.bash "$(pkg_fake_root_dir)/$(PREFIX)/share/bash-completion/completions/crystal"
	@#install -m644 etc/completion.zsh  "$(pkg_fake_root_dir)/$(PREFIX)/share/zsh/site-functions/_crystal"

create_custom: build-env configure build_custom fake_root_install_custom packages clean_working_dir
all:  create_custom
