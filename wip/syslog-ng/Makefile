name = syslog-ng
version = 3.30.1
pkgrel = 0
pkgdesc = "Next generation logging daemon"
url = "https://www.syslog-ng.com/products/open-source-log-management/"
arch = "all"
license = "GPL-2.0-or-later"
options = "!check" # unit tests require https://github.com/Snaipe/Criterion with deps
build-dependencies  = curl-dev eventlog-dev file bison flex autoconf automake libtool glib-dev hiredis-dev
build-dependencies += ivykis-dev>=0.42.4 libdbi-dev json-c-dev openssl-dev pcre-dev python3-dev rabbitmq-c-dev

install = $(name).post-install $(name).post-upgrade
URL = https://github.com/balabit/syslog-ng/releases/download/$(name)-$(version)/$(name)-$(version).tar.gz

MAKE_INSTALL_OPTIONS_USER = -j1

CONFIGURE_OPTIONS_USER = --sysconfdir=/etc/syslog-ng \
	--localstatedir=/run \
	--disable-extra-warnings \
	--enable-ipv6 \
	--enable-manpages \
	\
	--disable-sql \
	--disable-linux-caps \
	--disable-mongodb \
	--disable-json \
	--disable-amqp \
	--disable-stomp \
	--disable-smtp \
	--disable-http \
	--disable-redis \
	--disable-geoip \
	--disable-geoip2 \
	--disable-riemann \
	--disable-systemd \
	--disable-python \
	--disable-java \
	--disable-java-modules \
	--enable-native \
	--disable-rdrand
	#--with-ivykis=system \
	#--with-jsonc=system \
	#--with-librabbitmq-client=system


SYSCONF ?= ../../
include $(SYSCONF)/package.mk


pre_configure:
	# Remove bundled libraries
	rm -rf $(bdir)/lib/ivykis
	rm -rf $(bdir)/modules/afamqp/rabbitmq-c
	rm -rf $(bdir)/modules/afmongodb/mongo-c-driver
	cd $(bdir); autoreconf -if

post_fake_root_install:
	rm -rf $(pkg_fake_root_dir)/usr/lib/$(name)/libtest

	# rm -rf $(pkg_fake_root_dir)/run 

	# getent module doesn't build properly as musl doesn't support reentrant
	# getprotoby[number|name] funcs. The provided compat lib only patches
	# solaris, which does provide reentrant versions under a different sig
	rm -f $(bdir)/usr/lib/$(name)/libtfgetent.so

#	install -m 644 "$(bdir)"/$(name).conf $(pkg_fake_root_dir)/etc/$(name)/$(name).conf
#	install -D -m 755 "$(bdir)"/$(name).initd $(pkg_fake_root_dir)/etc/init.d/$(name)
#	install -D -m 644 "$(bdir)"/$(name).logrotate $(pkg_fake_root_dir)/etc/logrotate.d/$(name)
#
#	install -d -m 755 "$(pkg_fake_root_dir)"/etc/$(name)/conf.d
#	install -d -m 700 "$(pkg_fake_root_dir)"/var/lib/syslog-ng
