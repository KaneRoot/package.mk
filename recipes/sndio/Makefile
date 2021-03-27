name = sndio
version = 1.7.0
URL = https://sndio.org/sndio-$(version).tar.gz

ifeq (latest, true)
URL = https://sndio.org/sndio.tar.gz
endif

# configure script doesn't accept wrong options.
# We must enter only valid options.
# Currently, we only want to configure the prefix.
CONFIGURE_OPTIONS = --prefix=$(PREFIX)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
