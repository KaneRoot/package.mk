name = metasploit-omnibus
version = 6.0.40
release = 0
URL = https://github.com/rapid7/metasploit-omnibus/archive/refs/tags/$(version).tar.gz

dependencies =  ruby rubygems libpcap-devel postgresql-dev
build-dependencies = git ruby-bundler bison flex autoconf automake

#MAKE_INSTALL_OPTIONS_USER = prefix=$(PREFIX)

configure_backend = configure_custom
build_backend = 

SYSCONF ?= ../../
include $(SYSCONF)/package.mk

## TODO: remove this somehow, metasploit installer sucks.
#pre_configure:
#	sudo mkdir -p /var/cache/omnibus
#	sudo mkdir -p /opt/metasploit-framework
#	sudo chown `whoami` /var/cache/omnibus
#	sudo chown `whoami` /opt/metasploit-framework

configure_custom:
	cd $(bdir) && bundle binstubs --all

