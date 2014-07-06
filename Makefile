include theos/makefiles/common.mk

TWEAK_NAME = jb2
jb2_FILES = Tweak.xm
jb2_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
