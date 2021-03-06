/* SPDX-License-Identifier: GPL-2.0-only */
/* This file is part of the coreboot project. */

#include <memlayout.h>

#include <arch/header.ld>

/*
 * SRAM_L2C is the half part of L2 cache that we borrow to be used as SRAM.
 * It will be returned before starting the ramstage.
 * SRAM_L2C and SRAM can be cached, but only SRAM is DMA-able.
 */
#define SRAM_L2C_START(addr) SYMBOL(sram_l2c, addr)
#define SRAM_L2C_END(addr) SYMBOL(esram_l2c, addr)
#define DRAM_INIT_CODE(addr, size) \
	REGION(dram_init_code, addr, size, 4)

SECTIONS
{
	SRAM_START(0x00100000)
	VBOOT2_WORK(0x00100000, 12K)
	TPM_TCPA_LOG(0x00103000, 2K)
	FMAP_CACHE(0x00103800, 2K)
	WATCHDOG_TOMBSTONE(0x00104000, 4)
	PRERAM_CBMEM_CONSOLE(0x00104004, 63K - 4)
	TIMESTAMP(0x00113c00, 1K)
	STACK(0x00114000, 16K)
	TTB(0x00118000, 28K)
	DMA_COHERENT(0x0011f000, 4K)
	SRAM_END(0x00120000)

	SRAM_L2C_START(0x00200000)
	OVERLAP_DECOMPRESSOR_VERSTAGE_ROMSTAGE(0x00201000, 188K)
	BOOTBLOCK(0x00230000, 64K)
	DRAM_INIT_CODE(0x00240000, 208K)
	PRERAM_CBFS_CACHE(0x00274000, 48K)
	SRAM_L2C_END(0x00280000)

	DRAM_START(0x40000000)
	POSTRAM_CBFS_CACHE(0x40000000, 2M)
	RAMSTAGE(0x40200000, 256K)

	BL31(0x54600000, 0x60000)
}
