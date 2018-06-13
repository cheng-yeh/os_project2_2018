MODULENAME = master_device

obj-m += $(MODULENAME).o
CFLAGS_$(MODULENAME) := -Wall

all: module

module:
        make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
        make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

