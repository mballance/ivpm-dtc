
IVPM_DTC_SCRIPTS_DIR = $(dir $(lastword $(MAKEFILE_LIST)))
IVPM_DTC_DIR = $(abspath $(IVPM_DTC_SCRIPTS_DIR)/..)

BUILD_DIR = $(IVPM_DTC_DIR)/build

DTC_VERSION=1.4.6
DTC_DIR=dtc-$(DTC_VERSION)
DTC_TGZ=$(BUILD_DIR)/$(DTC_DIR).tar.gz
DTC_URL=https://github.com/dgibson/dtc/archive/v$(DTC_VERSION).tar.gz

PLATFORM=linux_x86_64


RULES := 1

build : $(IVPM_DTC_DIR)/$(PLATFORM)/dtc

$(IVPM_DTC_DIR)/$(PLATFORM)/dtc : $(BUILD_DIR)/dtc.unpack
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)cd $(BUILD_DIR)/$(DTC_DIR) ; $(MAKE)
	$(Q)cp $(BUILD_DIR)/$(DTC_DIR)/dtc $@

$(BUILD_DIR)/dtc.unpack : $(DTC_TGZ)
	$(Q)rm -rf $(BUILD_DIR)/$(DTC_DIR)
	$(Q)cd $(BUILD_DIR) ; tar xvzf $(DTC_TGZ)
	$(Q)touch $@

release :


$(DTC_TGZ) :
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)wget -O $@ $(DTC_URL)

