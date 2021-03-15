name = git
version = 2.31.0
release = 3
URL = https://mirrors.edge.kernel.org/pub/software/scm/git/$(name)-$(version).tar.xz

build-dependencies = curl \
	libressl-dev \
	perl \
	autoconf \
	automake \
	zlib-dev \
	gettext

dependencies = binutils

# Force JOBS=1, git cannot be built otherwise.
JOBS = 1

# -i prevents the use of gettext (msgfmt)
MAKE_OPTIONS_USER = -i
MAKE_INSTALL_OPTIONS_USER = -i

CONFIGURE_OPTIONS_USER = --prefix=$(PREFIX) \
	--with-curl --enable-openssl \
	--without-tcltk --disable-nls


SYSCONF ?= ../../
include $(SYSCONF)/package.mk

pre_configure:
	$(Q)[ -f $(bdir)/configure ] && ( \
		cd $(bdir) ; \
		make distclean ; \
		autoconf ; \
	)
