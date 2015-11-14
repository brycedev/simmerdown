include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SimmerDown
SimmerDown_FILES = SMDRootListController.m SMDSourceController.m
SimmerDown_INSTALL_PATH = /Library/PreferenceBundles
SimmerDown_FRAMEWORKS = UIKit
SimmerDown_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SimmerDown.plist$(ECHO_END)
