GO_EASY_ON_ME = 1
ARCHS = armv7 armv7s arm64
TARGET = iphone:latest:8.1
THEOS_DEVICE_IP=127.0.0.1
THEOS_DEVICE_PORT=2222

include $(THEOS)/makefiles/common.mk

TOOL_NAME = nosandxd
nosandxd_FILES = NSServer.m NSDelegate.m
nosandxd_INSTALL_PATH = /usr/libexec/
nosandxd_FRAMEWORKS = Foundation CoreFoundation
nosandxd_PRIVATE_FRAMEWORKS = AppSupport
nosandxd_LIBRARIES = rocketbootstrap

include $(THEOS_MAKE_PATH)/tool.mk

LIBRARY_NAME = libnosandx
libnosandx_FILES = NSClient.m
libnosandx_FRAMEWORKS = Foundation CoreFoundation
libnosandx_PRIVATE_FRAMEWORKS = AppSupport
libnosandx_LIBRARIES = rocketbootstrap

include $(THEOS_MAKE_PATH)/library.mk

after-nosandxd-stage::
	$(ECHO_NOTHING)echo " Adding Permissions"$(ECHO_END)
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/LaunchDaemons/ $(ECHO_END)
	$(ECHO_NOTHING)cp com.imokhles.nosandxdlaunch.plist $(THEOS_STAGING_DIR)/Library/LaunchDaemons/ $(ECHO_END)
	$(ECHO_NOTHING)chmod 644 $(THEOS_STAGING_DIR)/Library/LaunchDaemons/com.imokhles.nosandxdlaunch.plist$(ECHO_END)
	$(ECHO_NOTHING)chmod 4755 $(THEOS_STAGING_DIR)/usr/libexec/nosandxd$(ECHO_END)
	$(ECHO_NOTHING)echo " Permissions Finished"$(ECHO_END)

after-libnosandx-stage::
	$(ECHO_NOTHING)echo " Installing Library"$(ECHO_END)
	$(ECHO_NOTHING)cp  $(THEOS_STAGING_DIR)/usr/lib/libnosandx.dylib $(THEOS)/lib $(ECHO_END)
	$(ECHO_NOTHING)cp NSClient.h $(THEOS_STAGING_DIR)/usr/include/nosandx/ $(ECHO_END)
	$(ECHO_NOTHING)cp -r Rocket $(THEOS_STAGING_DIR)/usr/include/nosandx/Rocket/ $(ECHO_END)
	$(ECHO_NOTHING)cp -r $(THEOS_STAGING_DIR)/usr/include/nosandx/ $(THEOS)/include/nosandx/ $(ECHO_END)
	$(ECHO_NOTHING)echo " Library Installed"$(ECHO_END)

