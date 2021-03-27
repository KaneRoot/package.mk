name = cmake
version = 3.20.0
URL = https://github.com/Kitware/CMake/releases/download/v$(version)/cmake-$(version).tar.gz

# Force configure options, since it doesn't allow invalid options.
CONFIGURE_OPTIONS = --prefix=$(PREFIX)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
