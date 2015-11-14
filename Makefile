include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SimmerDown
SimmerDown_FILES = Tweak.xm BDSettingsManager.m UIImage+AnimatedGif.m
SimmerDown_FRAMEWORKS = Foundation ImageIO UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = com.brycedev.simmerdown
com.brycedev.simmerdown_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS)/makefiles/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += simmerdown
include $(THEOS_MAKE_PATH)/aggregate.mk
