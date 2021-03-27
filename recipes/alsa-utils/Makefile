name = alsa-utils
version = 1.2.4
URL = ftp://ftp.alsa-project.org/pub/utils/alsa-utils-$(version).tar.bz2

description = "alsa-utils contains various generic ALSA command line tools, such as amixer, aplay, alsaconf, etc."

build-dependencies = alsa-lib-dev ncurses-dev

CONFIGURE_OPTIONS_USER = --disable-nls --disable-xmlto  --disable-rst2man  --with-curses=ncursesw

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
