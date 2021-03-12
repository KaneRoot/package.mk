# Preferences, default environment.

# Used by default for working directory and log file names
gen_uuid != uuidgen

# TODO: patches => automatic patching + meta

# Main configuration variables

SLOT ?= /usr/baguette
PREFIX := $(SLOT)
BINDIR := $(PREFIX)/bin
LIBDIR := $(PREFIX)/lib
SHAREDIR := $(PREFIX)/share
INCLUDEDIR := $(PREFIX)/include
MANDIR := $(SHAREDIR)/man

ARCH_DETECTED != uname -m
ARCH ?= $(ARCH_DETECTED)

keep_build_env ?= false

Q ?= @

release ?= 0

export SLOT PREFIX BINDIR LIBDIR SHAREDIR INCLUDEDIR MANDIR

CC = clang
CXX = clang++
CFLAGS = -Os -Wall

# Options to pass to different build operations.
CONFIGURE_OPTIONS_USER ?=
CONFIGURE_OPTIONS ?= --disable-nls --without-gettext \
					$(CONFIGURE_OPTIONS_USER)

MAKE_OPTIONS_USER ?=
MAKE_OPTIONS ?= CC=$(CC) CXX=$(CXX) \
				"--prefix="$(PREFIX) \
				$(MAKE_OPTIONS_USER)

MAKE_INSTALL_OPTIONS_USER ?=
MAKE_INSTALL_OPTIONS ?= DESTDIR=$(pkg_fake_root_dir) \
						$(MAKE_INSTALL_OPTIONS_USER)

CMAKE_OPTIONS_USER ?= 
CMAKE_OPTIONS ?= "-DCMAKE_INSTALL_PREFIX="$(PREFIX) \
				"-DCMAKE_BUILD_TYPE=Release" \
				$(CMAKE_OPTIONS_USER) \
				"-- -j"$(BUILD_CORES)

PACKAGE_MANAGER ?= baguette # Available: baguette, apk

BUILD_CORES ?= 1

tarballs_directory   = /tmp/src# where to store package sources
repository_directory = /tmp/pkg# local package repository

WORKING_DIR ?= /tmp/packaging
UUID ?= $(gen_uuid)

pkg_working_dir   = $(WORKING_DIR)/$(UUID)
pkg_build_par_dir = $(pkg_working_dir)/build/
pkg_build_dir     = $(pkg_build_par_dir)/$(name)-$(version)
pkg_fake_root_dir = $(pkg_working_dir)/root

pkg_working_log = $(WORKING_DIR)/$(UUID).log

# shortcut
bdir ?= $(pkg_build_dir)

# Automatic process of the file extension.
auto_ext != echo $(URL) | grep -oE "(zip|tar.xz|tar.gz)$$"
ext ?= $(auto_ext)

baguette_ext := baguette

download_tool ?= wget


#
# Default implementations.
#

pre_configure pre_build pre_fake_root_install post_fake_root_install:
	@echo $@ => do nothing

#
# Misc
#

# Create directories
create_source_dir:
	mkdir -p $(tarballs_directory)
create_build_dir:
	mkdir -p $(pkg_build_par_dir)
	mkdir -p $(pkg_fake_root_dir)

# TODO: use these targets
# Clean directories
clean_build_dir:
	$(keep_build_env) || rm -rf $(pkg_build_par_dir)
clean_working_dir:
	$(keep_build_env) || rm -rf $(pkg_working_dir)

#
# Download sources
#

tarball = $(tarballs_directory)/$(name)-$(version).$(ext)

# Backends: ftp and wget
launch_download_ftp:
	@   [ -f $(tarball) ] || echo ftp -O $(tarball) $(URL)
	$(Q)[ -f $(tarball) ] || ftp -O $(tarball) $(URL)
launch_download_wget:
	@   [ -f $(tarball) ] || echo wget -O $(tarball) $(URL)
	$(Q)[ -f $(tarball) ] || wget -O $(tarball) $(URL)

# How to create the file (download).
$(tarball): launch_download_$(download_tool)
	@echo download of $@ done

download: create_source_dir $(tarball)

#
# Extraction
#

extract_zip:
	@echo "cd $(pkg_build_par_dir) && unzip $(tarball)"
	$(Q)cd $(pkg_build_par_dir) && unzip $(tarball)
extract_tar.%:
	@echo "cd $(pkg_build_par_dir) && tar xf $(tarball)"
	$(Q)cd $(pkg_build_par_dir) && tar xf $(tarball)

extract: create_build_dir extract_$(ext)
	@echo "Extracting: done"

#
# Configure
#

# Both will be run in case there is no user-defined configure.
configure_autotools:
	@echo "Configure: autotools"
	$(Q)[ -f $(bdir)/configure ] && ( \
			cd $(bdir); \
			echo `pwd` "$$ ./configure $(CONFIGURE_OPTIONS)"; \
			./configure $(CONFIGURE_OPTIONS); \
		) || ( \
			echo "no configure script - pass" \
		)

configure_cmake:
	@echo "Configure: cmake"
	$(Q)[ -f $(bdir)/CMakeLists.txt ] && ( \
			cd $(bdir); \
			echo `pwd` "$$ cmake . $(CMAKE_OPTIONS)"; \
			cmake . $(CMAKE_OPTIONS); \
		) || ( \
			echo "no CMakeLists.txt - pass" \
		)

configure: pre_configure configure_autotools configure_cmake
	@echo "Configure: done"

#
# Build
#

build_make:
	@echo "Build: make"
	$(Q)[ -f $(bdir)/Makefile ] && ( \
			cd $(bdir); \
			echo `pwd` "$$ make $(MAKE_OPTIONS)"; \
			make $(MAKE_OPTIONS); \
		) || ( \
			echo "no Makefile - pass" \
		)

build: pre_build build_make
	@echo "Build: done"

#
# Install in a fake root for packaging
#

fake_root_install_make:
	@echo "Install (fake root): make"
	$(Q)[ -f $(bdir)/Makefile ] && ( \
			cd $(bdir); \
			echo `pwd` "$$ make install $(MAKE_INSTALL_OPTIONS)"; \
			make install $(MAKE_INSTALL_OPTIONS); \
		) || ( \
			echo "no Makefile - pass" \
		)

fake_root_install: pre_fake_root_install fake_root_install_make post_fake_root_install
	@echo "Install (fake root): done"


#
# Base package and splits
#

export name version release
export URL description dependencies conflicts provides

package_base = $(repository_directory)/$(ARCH)/$(name)-$(version)-r$(release).$(baguette_ext)
package_base: $(package_base)
$(package_base):
	@echo "Packaging $@"
	cd $(pkg_fake_root_dir) && create-package $@

pkg_fake_root_src_dir = $(pkg_fake_root_dir)-src
pkg_fake_root_man_dir = $(pkg_fake_root_dir)-man
pkg_fake_root_dev_dir = $(pkg_fake_root_dir)-dev
pkg_fake_root_doc_dir = $(pkg_fake_root_dir)-doc

# src split
package_src = $(repository_directory)/$(ARCH)/$(name)-src-$(version)-r$(release).$(baguette_ext)
package_src: $(package_src)
$(package_src):
	@echo "Packaging $@"
	cd $(pkg_fake_root_src_dir) && dependencies="" conflicts="" provides="" create-package $@

# doc split
package_doc = $(repository_directory)/$(ARCH)/$(name)-doc-$(version)-r$(release).$(baguette_ext)
package_doc: $(package_doc)
$(package_doc):
	@echo "Packaging $@"
	cd $(pkg_fake_root_src_dir) && dependencies="" conflicts="" provides="" create-package $@

# man split
package_man = $(repository_directory)/$(ARCH)/$(name)-man-$(version)-r$(release).$(baguette_ext)
package_man: $(package_man)
$(package_man):
	@echo "Packaging $@"
	cd $(pkg_fake_root_src_dir) && dependencies="" conflicts="" provides="" create-package $@

# dev split
package_dev = $(repository_directory)/$(ARCH)/$(name)-dev-$(version)-r$(release).$(baguette_ext)
package_dev: $(package_dev)
$(package_dev):
	@echo "Packaging $@"
	cd $(pkg_fake_root_src_dir) && dependencies="" conflicts="" provides="" create-package $@


check_binaries_wget_or_ftp:
	@which ftp || which wget
check_binaries_tar:
	@which tar && which xz
check_binaries_zip:
	@which unzip
check_binaries: check_binaries_wget_or_ftp check_binaries_tar check_binaries_zip

splits: package_src package_doc package_man package_dev package_base
getting-build-env: check_binaries download extract
create: getting-build-env configure build fake_root_install splits clean_working_dir


# Targets not representing a file on the FS.
.PHONY: download \
	launch_download_* \
	splits package* \
	check_binaries \
	pre_* post_* configure* build* fake_root_install* create*

# Ignoring errors on these targets.
.IGNORE: pre_*
