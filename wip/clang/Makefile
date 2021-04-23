name = clang
version = 11.1.0
release = 0
#URL = https://github.com/llvm/llvm-project/releases/download/llvmorg-$(version)/cfe-$(version).src.tar.gz
URL = https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-$(version).tar.gz

# labs.h clang

dirname = build
pkg_build_dir = $(pkg_working_dir)/build/llvm-project-llvmorg-$(version)

# Minimalist version
CMAKE_OPTIONS_USER = -DCMAKE_PREFIX_PATH=$(PREFIX) \
	-DCMAKE_INSTALL_PREFIX=$(PREFIX) \
	-DCMAKE_BUILD_TYPE=Release

#CMAKE_OPTIONS_USER = -DCMAKE_PREFIX_PATH=$(PREFIX) \
#	-DCMAKE_INSTALL_PREFIX=$(PREFIX) \
#	-DCLANG_CONFIG_FILE_SYSTEM_DIR=$(PREFIX)/etc/clang \
#	-DCLANG_DEFAULT_CXX_STDLIB=libc++ \
#	-DCMAKE_CXX_COMPILER="clang++" \
#	-DCMAKE_CXX_FLAGS="$CXXFLAGS -stdlib=libc++ -include /usr/baguette/include/c++/v1/math.h -include $(pwd)/../labs.h -D__DEFINED_max_align_t" \
#	-DCMAKE_C_COMPILER="clang" \
#	-DCMAKE_C_FLAGS="$CFLAGS" \
#	-DCMAKE_EXE_LINKER_FLAGS="$LDFLAGS -lc++" \
#	-DCMAKE_SHARED_LINKER_FLAGS="$LDFLAGS -lc++" \
#	-DCMAKE_BUILD_TYPE=Release

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

#configure:
#	@#sed -i '/^  return ToolChain::CST_Libstdcxx/s@stdcxx@cxx@' cfe-$(version).src/tools/lib/Driver/ToolChain.cpp
#	mkdir -p $(bdir)/$(dirname)
#	$(Q)cd $(bdir)/$(dirname) ; \
#	cmake ../cfe-$(version).src \


post_fake_root_install:
	rm $(pkg_fake_root_dir)/$(PREFIX)/bin/clang
	rm $(pkg_fake_root_dir)/$(PREFIX)/bin/clang++
	cp clang $(pkg_fake_root_dir)/$(PREFIX)/bin/
	ln -s $(pkg_fake_root_dir)/$(PREFIX)/bin/clang $(pkg_fake_root_dir)/$(PREFIX)/bin/clang++
