name = curl
version = 7.75.0
release = 0
URL = https://curl.haxx.se/download/curl-$(version).tar.gz

# build-dependencies = make openssl-dev
build-dependencies = make libressl-dev

CONFIGURE_OPTIONS_USER = --prefix="$(PREFIX)" \
		--enable-ipv6 \
		--enable-unix-sockets \
		--enable-static \
		--enable-openssl \
		--without-libidn \
		--without-libidn2 \
		--with-nghttp2 \
		--disable-ldap \
		--with-pic \
		--without-libssh2 # https://bugs.alpinelinux.org/issues/10222

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure_cmake:
	@true

pre_build:
	mkdir -p $(pkg_fake_root_dir)/etc/ssl/certs/
	cp ca-certificates.crt $(pkg_fake_root_dir)/etc/ssl/certs/

