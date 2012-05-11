/* -*- linux-c -*- ------------------------------------------------------- *
 *
 *   Copyright (C) 1991, 1992 Linus Torvalds
 *   Copyright 2007 rPath, Inc. - All Rights Reserved
 *   Copyright 2009 Intel Corporation; author H. Peter Anvin
 *
 *   This file is part of the Linux kernel, and is made available under
 *   the terms of the GNU General Public License version 2.
 *
 * ----------------------------------------------------------------------- */

/*
 * main.c is working now
 */

#include "boot.h"

struct boot_params boot_params __attribute__((aligned(16)));

char *HEAP = _end;
char *heap_end = _end;

static void copy_boot_params(void)
{
        struct old_cmdline {
                u16 cl_magic;
                u16 cl_offset;
        };
        const struct old_cmdline * const oldcmd =
                (const struct old_cmdline *)OLD_CL_ADDRESS;

        BUILD_BUG_ON(sizeof boot_params != 4096);
        memcpy(&boot_params.hdr, &hdr, sizeof hdr);

        if (!boot_params.hdr.cmd_line_ptr &&
            oldcmd->cl_magic == OLD_CL_MAGIC) {
                /* Old-style command line protocol. */
                u16 cmdline_seg;

                /* Figure out if the command line falls in the region
                   of memory that an old kernel would have copied up
                   to 0x90000... */
                if (oldcmd->cl_offset < boot_params.hdr.setup_move_size)
                        cmdline_seg = ds();
                else
                        cmdline_seg = 0x9000;

                boot_params.hdr.cmd_line_ptr =
                        (cmdline_seg << 4) + oldcmd->cl_offset;
        }
}

static void set_bios_mode(void)
{
#ifdef CONFIG_X86_64
        struct biosregs ireg;

        initregs(&ireg);
        ireg.ax = 0xec00;
        ireg.bx = 2;
        intcall(0x15, &ireg, NULL);
#endif
}


static void init_heap(void)
{
        char *stack_end;

        if (boot_params.hdr.loadflags & CAN_USE_HEAP) {
                asm("leal %P1(%%esp),%0"
                    : "=r" (stack_end) : "i" (-STACK_SIZE));

                heap_end = (char *)
                        ((size_t)boot_params.hdr.heap_end_ptr + 0x200);
                if (heap_end > stack_end)
                        heap_end = stack_end;
        } else {
                /* Boot protocol 2.00 only, no heap available */
                puts("  WARNING: Ancient bootloader, some functionality "
                     "may be limited!\n");
        }
}

static void query_ist(void)
{
        struct biosregs ireg, oreg;

        /* Some older BIOSes apparently crash on this call, so filter
           it from machines too old to have SpeedStep at all. */
        if (cpu.level < 6)
                return;

        initregs(&ireg);
        ireg.ax  = 0xe980;       /* IST Support */
        ireg.edx = 0x47534943;   /* Request value */
        intcall(0x15, &ireg, &oreg);

        boot_params.ist_info.signature  = oreg.eax;
        boot_params.ist_info.command    = oreg.ebx;
        boot_params.ist_info.event      = oreg.ecx;
        boot_params.ist_info.perf_level = oreg.edx;
}



void main(void)
{

	puts("-----------Seperator------------\n");
	puts("It is in my main function now.\n");

	puts("-----------Seperator------------\n");
        copy_boot_params();
        puts("Successfully copied boot parameters. \n");

	puts("-----------Seperator------------\n");
        
        init_heap();
        puts("successfully init heap.\n");

        set_bios_mode();
	puts("successfully set bios mode.\n");
        
        detect_memory();
        puts("successfully detect_memory.\n");
	puts("-----------Seperator------------\n");
        
	query_mca();
	puts("successfully query mca. \n");
	
        query_ist();

        printf("successfully query ist.\n");

        query_apm_bios();

        printf("successfully query apm.\n");

        printf("by the way, we can use printf function now.\n");
        printf("testing printf, it is an integer:%d. \n",10);
	puts("-----------Seperator------------\n");
        


	int i;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;
	i=10000;













}
