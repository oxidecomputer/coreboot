/* SPDX-License-Identifier: GPL-2.0-only */
/* This file is part of the coreboot project. */

#include <console/uart.h>

#define VEXPRESS_UART0_IO_ADDRESS      (0x10009000)

uintptr_t uart_platform_base(int idx)
{
	return VEXPRESS_UART0_IO_ADDRESS;
}
