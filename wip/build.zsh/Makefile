name = build.zsh
version = 0.4.1
release = 0
URL = https://git.baguette.netlib.re/Baguette/build.zsh/archive/$(version).tar.gz

dependencies = make zsh

MAKE_INSTALL_OPTIONS_USER = PREFIX=$(PREFIX)

pkg_build_par_dir = $(pkg_working_dir)/build/
pkg_build_dir     = $(pkg_build_par_dir)/$(name)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
