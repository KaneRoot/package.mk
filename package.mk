# Used by default for working directory and log file names
gen_uuid != uuidgen

Q ?= @

# Main configuration variables

SLOT       ?= /usr/baguette
PREFIX     := $(SLOT)
BINDIR     := $(PREFIX)/bin
SBINDIR    := $(PREFIX)/sbin
LIBDIR     := $(PREFIX)/lib
SHAREDIR   := $(PREFIX)/share
INCLUDEDIR := $(PREFIX)/include
MANDIR     := $(SHAREDIR)/man

ARCH_DETECTED != uname -m
ARCH ?= $(ARCH_DETECTED)

CBUILD ?= $(ARCH)
CHOST  ?= $(ARCH)

# pkg info
# URL
release ?= 0
patches ?=
JOBS ?= 1

# Variables
builddir => bdir
pkgdir => pkg_fake_root_dir
srcdir => source_directory

# Options
#chrooted ?= false
ignore_build_deps ?= false
keep_build_env ?= false

# Do not try to install dependencies when there is none.
ifeq ("$(build-dependencies)", "")
install_build_dependencies ?=
else
install_build_dependencies ?= check_build_dependencies
endif
check_build_dependencies:
	@echo -e "\033[1;35;47mbuild-dependencies: $(build-dependencies)\033[0m"
	$(Q)[ "$(ignore_build_deps)" != "false" ] && echo "ignoring" || install-packages $(build-dependencies)

export SLOT PREFIX BINDIR SBINDIR LIBDIR SHAREDIR INCLUDEDIR MANDIR

CC ?= clang
CXX ?= clang++
CFLAGS_USER ?=
CFLAGS ?= -Os -Wall $(CFLAGS_USER)


tarballs_directory   = /tmp/src# where to store package sources
repository_directory = /tmp/pkg# local package repository

WORKING_DIR ?= /tmp/packaging
UUID ?= $(gen_uuid)

pkg_working_dir   ?= $(WORKING_DIR)/$(UUID)
pkg_build_par_dir ?= $(pkg_working_dir)/build/
pkg_build_dir     ?= $(pkg_build_par_dir)/$(name)-$(version)
pkg_fake_root_dir ?= $(pkg_working_dir)/root

log_file ?= $(pkg_working_dir)/log
log_it = >> $(log_file).info 2>> $(log_file).err
log_patching = >> $(log_file).patching.info 2>> $(log_file).patching.err

# shortcut
bdir ?= $(pkg_build_dir)


download_backend ?= $(tarball)

# Steps one may override.
configure_backend ?= configure_autotools configure_cmake
build_backend ?= build_make
fake_root_install_backend ?= fake_root_install_make
create_steps ?= build-env configure build fake_root_install packages clean_working_dir


# Automatic process of the file extension (to select the extracting tool).
auto_ext != echo $(URL) | grep -oE "(zip|tar.xz|tar.bz2|tgz|tar.gz)$$"
ext ?= $(auto_ext)


PACKAGE_MANAGER ?= baguette # Available: baguette, apk
export PACKAGE_MANAGER


# Options to pass to different build operations.
CONFIGURE_OPTIONS_USER ?=
CONFIGURE_OPTIONS ?= --disable-nls --without-gettext \
	--prefix=$(PREFIX) \
	$(CONFIGURE_OPTIONS_USER)

MAKE_OPTIONS_USER ?=
MAKE_OPTIONS ?= CC=$(CC) CXX=$(CXX) -j$(JOBS) \
	$(MAKE_OPTIONS_USER)

MAKE_INSTALL_OPTIONS_USER ?=
MAKE_INSTALL_OPTIONS ?= DESTDIR=$(pkg_fake_root_dir) \
	$(MAKE_INSTALL_OPTIONS_USER)

CMAKE_OPTIONS_USER ?=
CMAKE_OPTIONS ?= -DCMAKE_INSTALL_PREFIX=$(PREFIX) \
	-DCMAKE_BUILD_TYPE=Release \
	$(CMAKE_OPTIONS_USER)


package_ext := baguette
ifeq ($(PACKAGE_MANAGER), apk)
package_ext := apk
endif

download_tool ?= wget


#
# Default implementations.
#

pre_configure pre_build pre_fake_root_install post_fake_root_install:
	@echo "$@ => do nothing"

#
# Misc
#

# Create directories
create_source_dir:
	$(Q)mkdir -p $(tarballs_directory)
create_build_dir:
	$(Q)mkdir -p $(pkg_build_par_dir)
create_fake_root_dir:
	$(Q)mkdir -p $(pkg_fake_root_dir)
create_fake_root_src_dir:
	$(Q)mkdir -p $(pkg_fake_root_src_dir)
create_repository_dir:
	$(Q)mkdir -p $(repository_directory)/$(ARCH)

# Clean directories
clean_build_dir:
	$(Q)$(keep_build_env) || rm -rf $(pkg_build_par_dir)
clean_working_dir:
	$(Q)$(keep_build_env) || rm -rf $(pkg_working_dir)

#
# Download sources
#

tarball = $(tarballs_directory)/$(name)-$(version).$(ext)

# Backends: ftp and wget
download_ftp:
	@   [ -f $(tarball) ] || echo ftp -o $(tarball) $(URL)
	$(Q)[ -f $(tarball) ] || ftp -o $(tarball) $(URL)
download_wget:
	@   [ -f $(tarball) ] || echo wget -O $(tarball) $(URL)
	$(Q)[ -f $(tarball) ] || wget $(WGET_OPTS) -O $(tarball) $(URL)

# How to create the file (download).
$(tarball): download_$(download_tool)
	@echo download of $@ done

download: create_source_dir $(download_backend)

#
# Extraction
#

extract_zip:
	$(Q)cd $(pkg_build_par_dir) && unzip $(tarball)
extract_tar.%:
	$(Q)cd $(pkg_build_par_dir) && tar xf $(tarball)
extract_tgz:
	$(Q)cd $(pkg_build_par_dir) && tar xf $(tarball)

extract_backend ?= extract_$(ext)
ifeq ($(download_backend),)
extract_backend =
endif
extract: create_build_dir $(extract_backend)
	@echo "Extracting: done"

#
# Patching
#

$(patches):
	@echo "Copying patch '$@' in $(pkg_build_par_dir)"
	$(Q)cp $@ $(pkg_build_par_dir)
	@echo "Applying patch '$@'"
	$(Q)cd $(pkg_build_dir); patch -f < ../$@ $(log_patching) || \
		patch -f -p0 < ../$@ $(log_patching) || \
		patch -f -p1 < ../$@ $(log_patching)

patching: $(patches)

#
# Configure
#

# Both will be run in case there is no user-defined configure.
configure_autotools:
	$(Q)if [ -f $(bdir)/configure ]; then \
			cd $(bdir); \
			echo `pwd` "$$ ./configure $(CONFIGURE_OPTIONS)"; \
			echo `pwd` "$$ ./configure $(CONFIGURE_OPTIONS)" $(log_it); \
			./configure $(CONFIGURE_OPTIONS) $(log_it); \
		else \
			echo "no configure script - pass autotools backend"; \
		fi

configure_cmake:
	$(Q)if [ -f $(bdir)/CMakeLists.txt ]; then \
			cd $(bdir); \
			echo `pwd` "$$ cmake . $(CMAKE_OPTIONS)"; \
			echo `pwd` "$$ cmake . $(CMAKE_OPTIONS)" $(log_it); \
			cmake . $(CMAKE_OPTIONS) $(log_it); \
		else \
			echo "no CMakeLists.txt - pass cmake backend" ; \
		fi

configure: pre_configure $(configure_backend)
	@echo "Configure: done"

#
# Build
#

build_make:
	$(Q)if [ -f $(bdir)/Makefile ]; then \
			cd $(bdir); \
			echo `pwd` "$$ make $(MAKE_OPTIONS)"; \
			echo `pwd` "$$ make $(MAKE_OPTIONS)" $(log_it); \
			make $(MAKE_OPTIONS) $(log_it); \
		else \
			echo "no Makefile - pass" ; \
		fi

build: pre_build $(build_backend)
	@echo "Build: done"

#
# Install in a fake root for packaging
#

fake_root_install_make:
	$(Q)if [ -f $(bdir)/Makefile ]; then \
			cd $(bdir); \
			echo `pwd` "$$ make install $(MAKE_INSTALL_OPTIONS)"; \
			echo `pwd` "$$ make install $(MAKE_INSTALL_OPTIONS)" $(log_it); \
			make install $(MAKE_INSTALL_OPTIONS) $(log_it); \
		else \
			echo "no Makefile - pass" ; \
		fi

fake_root_install: create_fake_root_dir pre_fake_root_install $(fake_root_install_backend) post_fake_root_install
	@echo "Install (fake root): done"


#
# Base package and splits
#

export name version release
export URL description dependencies conflicts provides patches

package_base = $(repository_directory)/$(ARCH)/$(name)-$(version)-r$(release).$(package_ext)
package_base: $(package_base)
$(package_base):
	@echo "Packaging $@"
	@# strip binaries
	$(Q)cd $(pkg_fake_root_dir) && find . -type f | while read F ; do strip $F 2>/dev/null ; done ; :
	$(Q)cd $(pkg_fake_root_dir) && create-package $@ $(log_it)

export pkg_fake_root_src_dir  = $(pkg_fake_root_dir)-src
export pkg_fake_root_doc_dir  = $(pkg_fake_root_dir)-doc
export pkg_fake_root_man_dir  = $(pkg_fake_root_dir)-man
export pkg_fake_root_dev_dir  = $(pkg_fake_root_dir)-dev
export pkg_fake_root_libs_dir = $(pkg_fake_root_dir)-libs

extract_src_zip:
	$(Q)cd $(pkg_fake_root_src_dir) && unzip $(tarball)
extract_src_tar.%:
	$(Q)cd $(pkg_fake_root_src_dir) && tar xf $(tarball)
extract_src_tgz:
	$(Q)cd $(pkg_fake_root_src_dir) && tar xf $(tarball)

extract_src_backend = create_fake_root_src_dir extract_src_$(ext) $(package_src)
ifeq ($(download_backend),)
extract_src_backend =
endif

package_src = $(repository_directory)/$(ARCH)/$(name)-src-$(version)-r$(release).$(package_ext)
package_src: $(extract_src_backend)
$(package_src):
	@echo "Packaging $@"
	$(Q)[ ! -z "$(patches)" ] && cp -v $(patches) $(pkg_fake_root_src_dir) || :
	$(Q)cd $(pkg_fake_root_src_dir) && name=$(name)-src dependencies="" conflicts="" provides="" create-package $@ $(log_it)

package_doc = $(repository_directory)/$(ARCH)/$(name)-doc-$(version)-r$(release).$(package_ext)
package_doc: $(package_doc)
$(package_doc):
	@echo "Packaging $@"
	$(Q)cd $(pkg_fake_root_dir) && create-split-doc $(log_it)
	$(Q)if [ -d "$(pkg_fake_root_doc_dir)" ] ; then \
		cd $(pkg_fake_root_doc_dir) ; \
		name=$(name)-doc dependencies="" conflicts="" provides="" create-package $@ $(log_it) ; \
	else \
		echo -e "\033[0;35;40m>> no '$(pkg_fake_root_doc_dir)' directory\033[0m" ; \
	fi

package_man = $(repository_directory)/$(ARCH)/$(name)-man-$(version)-r$(release).$(package_ext)
package_man: $(package_man)
$(package_man):
	@echo "Packaging $@"
	$(Q)cd $(pkg_fake_root_dir) && create-split-man >> $(log_file).info 2>> $(log_file).err
	$(Q)if [ -d "$(pkg_fake_root_man_dir)" ] ; then \
		cd $(pkg_fake_root_man_dir) ; \
		name=$(name)-man dependencies="" conflicts="" provides="" create-package $@ $(log_it) ; \
	else \
		echo -e "\033[0;35;40m>> no '$(pkg_fake_root_man_dir)' directory\033[0m" ; \
	fi

package_dev = $(repository_directory)/$(ARCH)/$(name)-dev-$(version)-r$(release).$(package_ext)
package_dev: $(package_dev)
$(package_dev):
	@echo "Packaging $@"
	$(Q)cd $(pkg_fake_root_dir) && create-split-dev >> $(log_file).info 2>> $(log_file).err
	$(Q)if [ -d "$(pkg_fake_root_dev_dir)" ] ; then \
		cd $(pkg_fake_root_dev_dir) ; \
		name=$(name)-dev dependencies="" conflicts="" provides="" create-package $@ $(log_it) ; \
	else \
		echo -e "\033[0;35;40m>> no '$(pkg_fake_root_dev_dir)' directory\033[0m" ; \
	fi

package_libs = $(repository_directory)/$(ARCH)/$(name)-libs-$(version)-r$(release).$(package_ext)
package_libs: $(package_libs)
$(package_libs):
	@echo "Packaging $@"
	$(Q)cd $(pkg_fake_root_dir) && create-split-libs >> $(log_file).info 2>> $(log_file).err
	$(Q)if [ -d "$(pkg_fake_root_libs_dir)" ] ; then \
		cd $(pkg_fake_root_libs_dir) ; \
		name=$(name)-libs dependencies="" conflicts="" provides="" create-package $@ $(log_it) ; \
	else \
		echo -e "\033[0;35;40m>> no '$(pkg_fake_root_libs_dir)' directory\033[0m" ; \
	fi


check_binaries:
	@echo "Checking for required binaries (ftp or wget, tar & xz, unzip, zstd, strip)"
	which ftp >/dev/null || which wget >/dev/null
	which tar >/dev/null && which xz >/dev/null
	which unzip zstd strip >/dev/null
	which uuidgen >/dev/null
	[ $(PACKAGE_MANAGER) = "apk" ] && which abuild-sign abuild-tar >/dev/null || :
	@echo "Checking for required binaries (ftp or wget, tar & xz, unzip, zstd, strip): done"

splits: package_src package_doc package_man package_dev package_libs
# The main package is the last to be created since it includes
# all content that wasn't matched by splits.
packages: create_repository_dir splits package_base
build-env: check_binaries download extract patching
create: $(install_build_dependencies) $(create_steps)

include $(SYSCONF)/package.local.mk

# Targets not representing a file on the FS.
.PHONY: check_binaries download* splits package* build-env \
	$(patches) \
	pre_* post_* configure* build* fake_root_install* create*

# Ignoring errors on these targets.
.IGNORE: pre_*
