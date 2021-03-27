name = pcre
version = 8.44
URL = https://ftp.pcre.org/pub/pcre/pcre-$(version).tar.gz

CONFIGURE_OPTIONS_USER = --enable-utf8 \
	--enable-unicode-properties \
	--enable-pcre8 \
	--enable-pcre16 \
	--enable-pcre32 \
	--with-match-limit-recursion=8192


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
