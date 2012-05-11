Copy Linux step by step.

In order to learn Linux kernel, I decided to copy Linux source code step by step. And try to build and run it at each step, so that I can understand each part of Linux kernel.

It is version 0.0.8

#--------0.0.8
Try to go to protected mode.
In order to call go_to_protected_mode(), pm.c a20.c pmjump.S was added in the arch/x86/boot dir.
And, in order to run linux kernel , copy linux-0.2.img as hardisk image file.

#--------0.0.7
Try to call query_edd() and set_video().
The following files were added in the arch/x86/boot dir:
video-vesa.c video-vga.c video-mode.c video-bios.c video.c cmdline.c edd.c

#--------0.0.6
Try to call query_mca() query_ist() query_apm_bios().
In arch/x86/boot dir, we added files: mca.c copy.S apm.c cpu.c printf.c cpucheck.c string.c


#--------0.0.5
Try to call set_bios_mode and init_heap, then call detect_memory.
Code related to set_bios_mode and init_heap is added in the main.c file.
For calling detect_memory function, we add memory.c in the arch/x86/boot dir.


#--------0.0.4
Try to copy boot parameters from boot loader.
It is added in the main.c file.

#--------0.0.3
Now main.c is starting to work, print some messages with c program.
Inorder to call the function puts(), we add tty.c regs.c bioscall.S

#--------0.0.2
In this version, we still have the MBR in image, which is uselless just like the MBR in linux image, telling user that it is not supported anymore to load linux directlly.

Right after the MBR, we have the linux image header, which can make boot loader like GRUB can identify the image as linux kernel, although we are not a linux right now.

The linux image header code is copied from header.S in arch/x86/boot, with little modification.

As header.S depends on many *.h files, we copied all related *.h files from linux source folder.

To link the *.o file, we copied the setup.ld files from linux source folder.

To make the final bzImage file, we copied the build tool from arch/x86/boot/tools folder, and copied vmlinux.bin from linux folder.

In order to make setup.bin larger enough, we make a useless main.c and link the object files into setup.o.

The system can be loaded with "qemu -kernel ./bzImage", or loaded by GRUB.
Then displays some messages.

That is all we have now.


#--------0.0.1
Just copied first sector of header.S in arch/x86/boot.
Make it be able to boot from floppy disk and display some messages.

