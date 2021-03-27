name = rc
version = 0.0.1

rc_stuff = rc rc.conf rc.fix rc.local rc.modules rc.multi rc.shutdown rc.single
sources = $(rc_stuff) group inittab mdev.conf passwd sysctl.conf profile

create_steps = create_fake_root_dir fake_root_install_custom package_base clean_working_dir

fake_root_install_custom:
	$(Q)mkdir -p      '$(pkg_fake_root_dir)/proc'
	$(Q)mkdir -p      '$(pkg_fake_root_dir)/sys'
	$(Q)mkdir -p      '$(pkg_fake_root_dir)/dev'
	$(Q)mkdir -p      '$(pkg_fake_root_dir)/etc'
	$(Q)cp $(sources) '$(pkg_fake_root_dir)/etc/'

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
