include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SimmerDown
SimmerDown_FILES = Tweak.xm
SimmerDown_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
