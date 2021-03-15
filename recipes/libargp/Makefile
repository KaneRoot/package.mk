name = libargp
version = 1.3-1
release = 0
URL = https://github.com/amylum/libargp/releases/download/$(version)/libargp.tar.gz

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

configure:
	@echo -e "\033[0;37;45m'configure' operation only copies static files\033[0m"
	cp -r $(pkg_build_par_dir)/* $(pkg_fake_root_dir)/

build:
	@echo -e "\033[0;37;45m'build' operation does nothing\033[0m"

fake_root_install:
	@echo -e "\033[0;37;45m'fake_root_install' operation does nothing\033[0m"
