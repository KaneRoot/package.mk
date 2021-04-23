name = libcxx
version = 11.1.0
URL = https://github.com/llvm/llvm-project/releases/download/llvmorg-$(version)/$(name)-$(version).src.tar.xz

CMAKE_OPTIONS_USER = -DCMAKE_INSTALL_PREFIX=$(PREFIX) \
	-DCMAKE_BUILD_TYPE=Release \
	-DLIBCXX_HAS_MUSL_LIBC=ON \
	-DCMAKE_CXX_FLAGS="$(CXXFLAGS)" \
	-DLIBCXX_CXX_ABI=libcxxabi \
	-DCMAKE_C_FLAGS="$(CFLAGS)"

pkg_build_dir = $(pkg_build_par_dir)/$(name)-$(version).src

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
