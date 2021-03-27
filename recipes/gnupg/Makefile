name = gnupg
version = 2.2.27
release = 0
URL = https://gnupg.org/ftp/gcrypt/gnupg/gnupg-$(version).tar.bz2

build-dependencies = libgcrypt-dev libassuan-dev libnpth-dev libksba-dev
dependencies = libgpg-error libgcrypt libassuan pkgconf libnpth binutils libksba

CONFIGURE_OPTIONS_USER = --enable-gpg-is-gpg2 \
	\
	--disable-gpgsm \
	--disable-scdaemon \
	--disable-dirmngr \
	--disable-doc \
	--disable-gpgtar \
	--disable-wks-tools \
	--disable-selinux-support \
	--disable-exec \
	--disable-photo-viewers \
	--disable-card-support \
	--disable-ccid-driver \
	--disable-dirmngr-auto-start \
	--disable-sqlite \
	--disable-ntbtls \
	--disable-gnutls \
	--disable-ldap \
	--disable-rpath

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
