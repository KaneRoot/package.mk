name = ffmpeg
version = 4.3.2
URL = https://ffmpeg.org/releases/ffmpeg-$(version).tar.xz

build-dependencies = nasm

dependencies = alsa-lib

# ffmpeg doesn't tolerate invalid configure options.
CONFIGURE_OPTIONS = --prefix=$(PREFIX)

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
