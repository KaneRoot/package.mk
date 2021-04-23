name = gcc
version = 10.3.0
release = 0
URL = - https://ftp.gnu.org/gnu/gcc/gcc-$(version)/gcc-$(version).tar.xz

build-dependencies = gmp-dev mpfr-dev mpc-dev

dependencies = gmp mpfr mpc binutils

pkg_build_dir = $(pkg_build_par_dir)/build

configure:
	mkdir $(dirname)
	cd $(dirname)

	if [ "$(uname -m)" = x86_64 ]; then
		sed -e '/m64=/s/lib64/lib/' ../gcc-$(version)/gcc/config/i386/t-linux64 > tmp
		mv tmp ../gcc-$(version)/gcc/config/i386/t-linux64
	fi

	export CC=gcc
	export CXX=g++

	../gcc-$(version)/configure \
		CFLAGS="$CFLAGS -isystem $(prefix)/include" \
		CXXFLAGS="$CXXFLAGS -isystem $(prefix)/include" \
		--with-tune=generic \
		\
		--prefix=$(prefix) \
		--libdir=$(prefix)/lib \
		--disable-multilib \
		--disable-libssp \
		--disable-libmpx \
		--disable-libmudflap \
		--disable-libsanitizer \
		--disable-bootstrap \
		--disable-nls \
		--disable-werror \
		--enable-languages=c,c++ \
		--build=x86_64-weird-linux-musl

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
