name = hello
version = 2.10
URL = https://ftp.gnu.org/gnu/hello/hello-$(version).tar.gz

dependencies = gettext
build-dependencies = make

watch:
	curl 'https://ftp.gnu.org/gnu/hello/' -o- 2>/dev/null | \
		sed -n "/hello-.*\.tar\.gz/{s/\.tar\.gz.*//;s/.*hello-//;p}" | \
		tail -1


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
