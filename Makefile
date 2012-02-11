#
# $Id: Makefile 38 2004-09-11 11:15:09Z erwin $
#

ifneq ($(KERNELRELEASE),)

obj-m := dmx_usb.o

else

default modules all:
	$(MAKE) -C $(KERNELPATH) SUBDIRS=$(PWD) modules
	gcc -O2 -pipe -Wall dmx_usb_test.c -o dmx_usb_test

endif

clean:
	rm -f *.o *.ko
	rm -f dmx_usb_test
	rm -f dmx_usb.mod.c
	rm -f .dmx_usb.*
	rm -rf .tmp_versions
	rm -f Module.markers  modules.order  Module.symvers


