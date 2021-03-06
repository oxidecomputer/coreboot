##
## This file is part of the coreboot project.
##
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; version 2 of the License.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##

ifeq ($(CONFIG_EC_HP_KBC1126),y)
KBC1126_EC_INSERT:=$(top)/util/kbc1126/kbc1126_ec_insert
INTERMEDIATE+=kbc1126_ec_insert

ifeq ($(CONFIG_KBC1126_FIRMWARE),y)
cbfs-files-y += ecfw1.bin
cbfs-files-y += ecfw2.bin

ecfw1.bin-file := $(call strip_quotes,$(CONFIG_KBC1126_FW1))
ecfw1.bin-position := $(CONFIG_KBC1126_FW1_OFFSET)
ecfw1.bin-type := raw

ecfw2.bin-file := $(call strip_quotes,$(CONFIG_KBC1126_FW2))
ecfw2.bin-position := $(CONFIG_KBC1126_FW2_OFFSET)
ecfw2.bin-type := raw
endif

kbc1126_ec_insert: $(obj)/coreboot.pre
ifeq ($(CONFIG_KBC1126_FIRMWARE),y)
	printf "    Building kbc1126_ec_insert.\n"
	$(MAKE) -C util/kbc1126
	printf "    KBC1126    Inserting KBC1126 firmware blobs.\n"
	$(KBC1126_EC_INSERT) $(obj)/coreboot.pre \
		$(CONFIG_KBC1126_FW1_OFFSET) $(CONFIG_KBC1126_FW2_OFFSET)
endif

PHONY+=kbc1126_ec_insert

build_complete::
ifeq ($(CONFIG_KBC1126_FIRMWARE),)
	printf "\n** WARNING **\n"
	printf "You haven't added the firmware blobs for KBC1126 EC.\n"
	printf "You may be unable to power on your laptop without these blobs.\n"
	printf "Please select the following option to add them:\n\n"
	printf "  Chipset --->\n"
	printf "    [*] Add firmware images for KBC1126 EC\n\n"
	printf "You can read util/kbc1126/README.md for details.\n\n"
endif

ramstage-y += ec.c
bootblock-y += early_init.c
romstage-y += early_init.c

endif
