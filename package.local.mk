apkindex:
	$(Q)cd $(repository_directory)/$(ARCH) && ( \
		apk index -o APKINDEX.tar.gz *.apk; \
		abuild-sign APKINDEX.tar.gz; \
	)
