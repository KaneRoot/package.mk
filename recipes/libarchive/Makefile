name = libarchive
version = 3.5.1
release = 0
URL = https://www.libarchive.org/downloads/libarchive-$(version).tar.gz
build-dependencies = xz-dev zlib-static bzip2-static lzo-dev zstd-static
#build-dependencies = xz-dev zlib-dev bzip2-dev lzo-dev zstd-dev
dependencies = xz zlib bzip2 lzo zstd

CONFIGURE_OPTIONS_USER = --with-zlib --with-lzo2 --with-lzma --with-bz2lib --with-zstd \
	--without-cng --without-nettle --without-expat --without-xml2 \
	--without-openssl \
	--enable-posix-regex-lib=libc \
	LDFLAGS="-L$(PREFIX)/lib -static"

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure_cmake:
	@true

pre_fake_root_install:
	@echo -e "\033[0;37;40m>> pre-fake-root-install, statically compile bsd(tar|cpio|cat)\033[0m"
	cd $(bdir); \
	for i in tar cpio cat; do \
		$(CC) -static -o bsd$${i} $${i}/*.o \
			.libs/libarchive.a .libs/libarchive_fe.a \
			-llzma -lzstd -lz -lbz2 ;\
	done

# FIXME: We’ll want to use those as default `tar`, `cpio` and `zcat`
#        implementations in the future.

pkg_bsdtar = $(repository_directory)/$(ARCH)/$(name)-bsdtar-$(version)-r$(release).apk
fr_bsdtar = $(pkg_fake_root_dir)-bsdtar
split_bsdtar: $(pkg_bsdtar)
$(pkg_bsdtar):
	@echo "Packaging $@"
	mkdir -p $(fr_bsdtar)/$(PREFIX)/bin
	cp $(pkg_fake_root_dir)/$(PREFIX)/bin/bsdtar $(fr_bsdtar)/$(PREFIX)/bin/bsdtar
	$(Q)if [ -d "$(fr_bsdtar)" ]; then \
		cd $(fr_bsdtar) ; \
		dependencies="libarchive" conflicts="" provides="cmd:bsdtar" create-package $@ \
		>> $(log_file).info 2>> $(log_file).err ; \
	else \
		echo "\033[1;35;40m>> Error: no '$(fr_bsdtar)' directory\033[0m"; \
		exit 1; \
	fi

pkg_bsdcpio = $(repository_directory)/$(ARCH)/$(name)-bsdcpio-$(version)-r$(release).apk
fr_bsdcpio = $(pkg_fake_root_dir)-bsdcpio
split_bsdcpio: $(pkg_bsdcpio)
$(pkg_bsdcpio):
	@echo "Packaging $@"
	mkdir -p $(fr_bsdcpio)/$(PREFIX)/bin
	cp $(pkg_fake_root_dir)/$(PREFIX)/bin/bsdcpio $(fr_bsdcpio)/$(PREFIX)/bin/bsdcpio
	$(Q)if [ -d "$(fr_bsdcpio)" ]; then \
		cd $(fr_bsdcpio) ; \
		dependencies="libarchive" conflicts="" provides="cmd:bsdcpio" create-package $@ \
		>> $(log_file).info 2>> $(log_file).err ; \
	else \
		echo "\033[1;35;40m>> Error: no '$(fr_bsdcpio)' directory\033[0m"; \
		exit 1; \
	fi

pkg_bsdcat = $(repository_directory)/$(ARCH)/$(name)-bsdcat-$(version)-r$(release).apk
fr_bsdcat = $(pkg_fake_root_dir)-bsdcat
split_bsdcat: $(pkg_bsdcat)
$(pkg_bsdcat):
	@echo "Packaging $@"
	mkdir -p $(fr_bsdcat)/$(PREFIX)/bin
	cp $(pkg_fake_root_dir)/$(PREFIX)/bin/bsdcat $(fr_bsdcat)/$(PREFIX)/bin/bsdcat
	$(Q)if [ -d "$(fr_bsdcat)" ]; then \
		cd $(fr_bsdcat) ; \
		dependencies="libarchive" conflicts="" provides="cmd:bsdcat" create-package $@ \
		>> $(log_file).info 2>> $(log_file).err ; \
	else \
		echo "\033[1;35;40m>> Error: no '$(fr_bsdcat)' directory\033[0m"; \
		exit 1; \
	fi

splits: split_bsdcat split_bsdtar split_bsdcpio
