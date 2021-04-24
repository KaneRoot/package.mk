name = groff
version = 1.22.4
pkgrel = 0
pkgdesc = "GNU troff text-formatting system"
url = "https://www.gnu.org/software/groff/groff.html"
arch = "all"
license = "GPL-3.0-or-later"
build-dependencies = perl bison zlib-dev texinfo
URL = https://ftp.gnu.org/gnu/$(name)/$(name)-$(version).tar.gz

CONFIGURE_OPTIONS_USER = --without-x --disable-rpath

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

post_fake_root_install:
	rm -rf "$(pkg_fake_root_dir)"/$(PREFIX)/lib/charset.alias
	rmdir -p "$(pkg_fake_root_dir)"/$(PREFIX)/lib 2>/dev/null || true

	for f in man mdoc; do \
		cat site.tmac >> $(pkg_fake_root_dir)/$(SHAREDIR)/groff/site-tmac/$${f}.local ; \
	done

	# Prevent conflict with mandoc-doc
	rm -f "$(pkg_fake_root_dir)"/$(MANDIR)/man1/soelim.1 \
		"$(pkg_fake_root_dir)"/$(MANDIR)/man7/roff.7

pre_build:
	@# work around parallel build issue
	$(Q)cd $(bdir) ; make arch/misc && make
