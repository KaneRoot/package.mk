name = gtar
version = 1.34
release = 0
URL = http://ftp.gnu.org/gnu/tar/tar-$(version).tar.gz

pkg_build_dir = $(pkg_build_par_dir)/tar-$(version)

CONFIGURE_OPTIONS_USER = FORCE_UNSAFE_CONFIGURE=1 --program-prefix=g --without-selinux --disable-nls

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
