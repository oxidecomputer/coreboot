/* SPDX-License-Identifier: GPL-2.0-only */
/* This file is part of the coreboot project. */

/*
 * ISA portions taken from QEMU acpi-dsdt.dsl.
 */

// Intel LPC Bus Device  - 0:4.0
Device (LPCB)
{
	Name(_ADR, 0x00040000)

	OperationRegion(PCIC, PCI_Config, 0x00, 0x100)

	/* PS/2 keyboard (seems to be important for WinXP install) */
	Device (KBD)
	{
		Name (_HID, EisaId ("PNP0303"))
		Method (_STA, 0, NotSerialized)
		{
			Return (0x0f)
		}
		Method (_CRS, 0, NotSerialized)
		{
			Name (TMP, ResourceTemplate () {
				IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
				IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
				IRQNoFlags () {1}
			})
			Return (TMP)
		}
	}

	/* PS/2 mouse */
	Device (MOU)
	{
		Name (_HID, EisaId ("PNP0F13"))
		Method (_STA, 0, NotSerialized)
		{
			Return (0x0f)
		}
		Method (_CRS, 0, NotSerialized)
		{
			Name (TMP, ResourceTemplate () {
			     IRQNoFlags () {12}
			})
			Return (TMP)
		}
	}

	/* PS/2 floppy controller */
	Device (FDC0)
	{
		Name (_HID, EisaId ("PNP0700"))
		Method (_STA, 0, NotSerialized)
		{
			Return (0x0f)
		}
		Method (_CRS, 0, NotSerialized)
		{
			Name (BUF0, ResourceTemplate () {
				IO (Decode16, 0x03F2, 0x03F2, 0x00, 0x04)
				IO (Decode16, 0x03F7, 0x03F7, 0x00, 0x01)
				IRQNoFlags () {6}
				DMA (Compatibility, NotBusMaster, Transfer8) {2}
			})
			Return (BUF0)
		}
	}
}

Device(MBRS) {
	Name (_HID, EisaId ("PNP0C02"))
	Name (_UID, 0x01)

	External(_CRS) /* Resource Template in SSDT */
}
