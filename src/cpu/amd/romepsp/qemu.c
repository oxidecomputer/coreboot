/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <cpu/cpu.h>
#include <console/console.h>
#include <device/device.h>
#include <cpu/x86/lapic.h>

static void romepsp_cpu_init(struct device *dev)
{
	print_func_entry();
	setup_lapic();
	print_func_exit();
}

static struct device_operations cpu_dev_ops = {
	.init = romepsp_cpu_init,
};

static const struct cpu_device_id cpu_table[] = {
	{ X86_VENDOR_AMD, 0x830f10 },
	{ 0, 0 },
};

static const struct cpu_driver driver __cpu_driver = {
	.ops      = &cpu_dev_ops,
	.id_table = cpu_table,
};

struct chip_operations cpu_amd_romepsp_ops = {
	CHIP_NAME("AMD PSP x86 CPU")
};