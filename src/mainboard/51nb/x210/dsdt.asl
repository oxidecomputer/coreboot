/* SPDX-License-Identifier: GPL-2.0-or-later  */
/* This file is part of the coreboot project. */

#include <arch/acpi.h>

DefinitionBlock(
	"dsdt.aml",
	"DSDT",
	0x05,		// DSDT revision: ACPI v5.0
	OEM_ID,
	ACPI_TABLE_CREATOR,
	0x20110725	// OEM revision
)
{
	#include "acpi/platform.asl"

	#include <soc/intel/skylake/acpi/globalnvs.asl>

	#include <cpu/intel/common/acpi/cpu.asl>

	Device (\_SB.PCI0)
	{
		#include <soc/intel/skylake/acpi/systemagent.asl>
		#include <soc/intel/skylake/acpi/pch.asl>
		#include "acpi/graphics.asl"
	}

	#include <southbridge/intel/common/acpi/sleepstates.asl>

	// Mainboard specific
	#include "acpi/mainboard.asl"
}
