name = prename
version = 1.0
release = 0

dependencies = perl

# skip download, configuration, build, install
create_steps = create_fake_root_dir fake_root_install_custom package_base clean_working_dir

fake_root_install_custom:
	#$(Q)install -d -m0555 "$(pkg_fake_root_dir)/$(BINDIR)/"
	$(Q)mkdir -p "$(pkg_fake_root_dir)/$(BINDIR)/"
	$(Q)cp prename "$(pkg_fake_root_dir)/$(BINDIR)/"


SYSCONF ?= ../../
include $(SYSCONF)/package.mk
