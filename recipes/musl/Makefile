name = musl
version = 1.2.2
URL = https://www.musl-libc.org/releases/musl-$(version).tar.gz

# Edit this if you somehow need to build a prefixed version of musl.
SLOT ?= /
libdir = $(SLOT)/lib

configure_backend = configure_autotools
CONFIGURE_OPTIONS_USER = --libdir=$(PREFIX)/lib --syslibdir=$(libdir) --enable-shared --enable-static

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

post_fake_root_install:
	# FIXME: This’ll have to eventually be more automated.
	# FIXME: That path has to be edited on other architectures.
	$(Q)mkdir -p                  $(pkg_fake_root_dir)/etc
	$(Q)echo $(libdir)         >> $(pkg_fake_root_dir)/etc/ld-musl-x86_64.path
	$(Q)echo /usr/baguette/lib >> $(pkg_fake_root_dir)/etc/ld-musl-x86_64.path
	$(Q)echo /usr/bad/lib      >> $(pkg_fake_root_dir)/etc/ld-musl-x86_64.path
	$(Q)echo /usr/local/lib    >> $(pkg_fake_root_dir)/etc/ld-musl-x86_64.path

	for lib in libm libpthread librt libdl; do \
		ln -s $(libdir)/libc.so "$(pkg_fake_root_dir)/$(libdir)/$${lib}.so" ; \
	done
