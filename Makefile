# name of the project, the binaries will be generated with this name
PROJ_NAME = HedgehogLightFirmware

#directory for binary output files
BUILDDIR := build

.PHONY: all env clean-env clean flash

# build the firmware in the bundled project
all: $(PROJ_NAME)/$(BUILDDIR)/$(PROJ_NAME).bin

# set up the python environment for the HWC Flasher
env:
	python3 -m virtualenv env
	. env/bin/activate && pip install -e HedgehogHWCFlasher

# clean up the python environment for the HWC Flasher
clean-env:
	rm -rf env

# build the firmware in the bundled project
$(PROJ_NAME)/$(BUILDDIR)/$(PROJ_NAME).bin:
	cd $(PROJ_NAME) && make $(BUILDDIR)/$(PROJ_NAME).bin

# clean up the firmware in the bundled project
clean:
	cd $(PROJ_NAME) && make clean

# flash the firmware from the bundled project
flash:
	. env/bin/activate && cd $(PROJ_NAME) && make flash

# flash a binary from /tmp/$(PROJ_NAME).bin that was put there by someone else
flash-tmp:
	. env/bin/activate && hedgehog-hwc-flasher /tmp/$(PROJ_NAME).bin
