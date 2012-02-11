#
# Copyright (C) 2012 Christoph Thelen
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=dmx_usb_module
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define KernelPackage/dmx_usb_module
	SUBMENU:=USB Support
	TITLE:=DMX USB Module
	FILES:=$(PKG_BUILD_DIR)/dmx_usb.$(LINUX_KMOD_SUFFIX)
	KCONFIG:=
endef

define KernelPackage/dmx_usb_module/description
	Zur Ansteuerung des DMX-Panels.
endef

EXTRA_KCONFIG:= \
	
EXTRA_CFLAGS:= \
	

DMX_MAKE_OPTS:= -C $(PKG_BUILD_DIR) \
	PATH="$(TARGET_PATH)" \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	TARGET="$(HAL_TARGET)" \
	TOOLPREFIX="$(KERNEL_CROSS)" \
	TOOLPATH="$(KERNEL_CROSS)" \
	KERNELPATH="$(LINUX_DIR)" \
	LDOPTS=" " \
	EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
	$(EXTRA_KCONFIG)

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) $(DMX_MAKE_OPTS) M=$(PKG_BUILD_DIR) modules
endef

$(eval $(call KernelPackage,dmx_usb_module))
