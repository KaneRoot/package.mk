name: libcxxabi
version: 8.0.1
# for version 9.X and later
# sources: http://releases.llvm.org/%{version}/libcxxabi-%{version}.src.tar.xz
sources:
	- https://github.com/llvm/llvm-project/releases/download/llvmorg-%{version}/libcxxabi-%{version}.src.tar.xz
	- https://gist.github.com/jhuntwork/5805976/raw/110325d22d689a87727a03ebe8c5fee4bf45cede/libcxxabi.patch

dirname: %{name}-%{version}.src/lib

@configure
	mkdir build
	cd build
	#sed -i -e "/-nostdinc++/d" CMakeLists.txt
	cmake ../%{name}-%{version}.src \
		-DLIBCXXABI_LIBCXX_INCLUDES=%{prefix}/include/c++/v1 \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_CXX_COMPILER="clang" \
		-DCMAKE_CXX_FLAGS="$CXXFLAGS -D__DEFINED_max_align_t" \
		-DCMAKE_C_COMPILER="clang" \
		-DCMAKE_C_FLAGS="$CFLAGS" \
		-DLIBCXXABI_INCLUDE_TESTS=OFF \
		-DLLVM_ENABLE_LIBCXX=ON \
		-DCMAKE_INSTALL_PREFIX=%{prefix}

@build
	cd build
	make

@install
	cd build
	make DESTDIR="%{pkg}" install
	mkdir -p %{pkg}%{prefix}/include
	cp ../%{name}-%{version}.src/include/* %{pkg}%{prefix}/include

#@build
#	cd libcxxabi-%{version}.src/lib
#	export CXX="clang++ $CXXFLAGS -I%{prefix}/include/c++/v1/ -I%{prefix}/include"
#	./buildit

#@install
#	cd libcxxabi-%{version}.src/lib
#	mkdir -p %{pkg}%{prefix}/lib
#	cp -a libc++abi.* %{pkg}%{prefix}/lib
