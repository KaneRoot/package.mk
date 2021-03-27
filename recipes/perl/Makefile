name = perl
version = 5.32.1
release = 0
URL = https://www.cpan.org/src/5.0/perl-$(version).tar.gz

build-dependencies = zlib-dev bzip2-dev
dependencies = zlib bzip2

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure_custom: pre_configure
	cd $(bdir) ; \
	BUILD_ZLIB=0 ; \
	BUILD_BZIP2=0 ; \
	BZIP2_LIB=$(PREFIX)/lib ; \
	BZIP2_INCLUDE=$(PREFIX)/include ; \
	export BUILD_ZLIB BUILD_BZIP2 BZIP2_LIB BZIP2_INCLUDE ; \
	./Configure -des -Dcccdlflags='-fPIC' \
		-Dcccdlflags='-fPIC' \
		-Dccdlflags='-rdynamic' \
		-Dprefix=$(PREFIX) \
		-Uprivlib=$_privlib \
		-Darchlib=$_archlib \
		-Dvendorprefix=$(PREFIX) \
		-Dvendorlib=$(PREFIX)/share/perl5/vendor_perl \
		-Dvendorarch=$(PREFIX)/lib/perl5/vendor_perl \
		-Dsiteprefix=$(PREFIX)/local \
		-Dsitelib=$(PREFIX)/local/share/perl5/site_perl \
		-Dsitearch=$(PREFIX)/local/lib/perl5/site_perl \
		-Dlocincpth=' ' \
		-Dcc=gcc \
		-Uoptimize="$CFLAGS" \
		-Duselargefiles -Dusethreads \
		-Duseshrplib \
		-Dd_semctl_semun \
		-Dman1dir=$(PREFIX)/share/man/man1 \
		-Dman3dir=$(PREFIX)/share/man/man3 \
		-Dinstallman1dir=$(PREFIX)/share/man/man1 \
		-Dinstallman3dir=$(PREFIX)/share/man/man3 \
		-Dman1ext='1' \
		-Dman3ext='3pm' \
		-Dcf_by='Alpine' \
		-Ud_csh -Dusenm || return 1

build_custom: pre_build build_make
	cd $(bdir) ; \
	BUILD_ZLIB=0 ; \
	BUILD_BZIP2=0 ; \
	BZIP2_LIB=$(PREFIX)/lib ; \
	BZIP2_INCLUDE=$(PREFIX)/include ; \
	export BUILD_ZLIB BUILD_BZIP2 BZIP2_LIB BZIP2_INCLUDE ; \
	make libperl.so && make || return 1

create_custom: build-env configure_custom build_custom fake_root_install packages clean_working_dir
all:  create_custom
