include theos/makefiles/common.mk

BUNDLE_NAME = LockCustomizer
LockCustomizer_FILES = LockCustomizer.mm
LockCustomizer_INSTALL_PATH = /Library/PreferenceBundles
LockCustomizer_FRAMEWORKS = UIKit
LockCustomizer_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LockCustomizer.plist$(ECHO_END)
