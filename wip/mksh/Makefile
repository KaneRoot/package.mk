name = mksh
version = 59c
URL = https://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R$(version).tgz

dependencies =
build-dependencies =

pkg_build_dir = $(pkg_build_par_dir)/mksh

# This test case checks if a controlling tty is not present when
# '-C regress:no-ctty' has been passed. However, a controlling
# tty might be present when building this APKBUILD locally but
# isn't present on the builder. To make sure the tests pass both
# locally and on the builders we remove this test case.
pre_build:
	$(Q)sed -i $(bdir)/check.t -e '/^name: selftest-tty-absent$/,/^---$/d'

# Static build.
LDSTATIC=-static
export LDSTATIC

build_backend = build_custom
build_custom:
	@echo "$(bdir) $$ sh Build.sh -r"
	$(Q)cd $(bdir); sh Build.sh -r $(log_it)

fake_root_install_backend = fake_root_install_custom
fake_root_install_custom:
	$(Q)cd $(bdir); install -Dm755 mksh "$(pkg_fake_root_dir)"/$(PREFIX)/mksh
	$(Q)cd $(bdir); install -Dm644 dot.mkshrc "$(pkg_fake_root_dir)"/etc/skel/.mkshrc
	$(Q)cd $(bdir); install -Dm644 mksh.1 "$(pkg_fake_root_dir)"/$(MANDIR)/man1/mksh.1

SYSCONF ?= ../../
include $(SYSCONF)/package.mk
