bootdir:=arch/x86/boot/

gcc_c_flags:=-nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -include $(bootdir)boot.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -ffreestanding -fno-toplevel-reorder -fno-stack-protector -mpreferred-stack-boundary=2 -m32 -c

gcc_as_flags:=-nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude  -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA   -c


bzImage:$(bootdir)setup.bin $(bootdir)vmlinux.bin
	$(bootdir)/tools/build $(bootdir)setup.bin $(bootdir)vmlinux.bin CURRENT > $(bootdir)bzImage

run:
	qemu -hda ./linux-0.2.img -kernel $(bootdir)bzImage -append root=/dev/sda

$(bootdir)setup.bin:$(bootdir)setup.elf
	objcopy -O binary $(bootdir)setup.elf $(bootdir)setup.bin

$(bootdir)setup.elf: $(bootdir)header.o $(bootdir)main.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)memory.o $(bootdir)mca.o $(bootdir)copy.o $(bootdir)apm.o $(bootdir)cpu.o $(bootdir)printf.o $(bootdir)cpucheck.o $(bootdir)string.o $(bootdir)edd.o $(bootdir)cmdline.o $(bootdir)video.o $(bootdir)video-vesa.o $(bootdir)video-vga.o $(bootdir)video-mode.o $(bootdir)video-bios.o $(bootdir)pmjump.o $(bootdir)a20.o $(bootdir)pm.o 
	ld -m elf_i386 -T $(bootdir)setup.ld $(bootdir)header.o $(bootdir)main.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)memory.o $(bootdir)mca.o $(bootdir)copy.o $(bootdir)apm.o $(bootdir)cpu.o $(bootdir)printf.o $(bootdir)cpucheck.o $(bootdir)string.o $(bootdir)edd.o $(bootdir)cmdline.o $(bootdir)video.o $(bootdir)video-vesa.o $(bootdir)video-vga.o $(bootdir)video-mode.o $(bootdir)video-bios.o $(bootdir)pmjump.o $(bootdir)a20.o $(bootdir)pm.o -o $(bootdir)setup.elf

$(bootdir)header.o: $(bootdir)header.S
	gcc -nostdinc -Iinclude -include include/generated/autoconf.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -include ./code16gcc.h -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA -Iarch/x86/boot  -c -o $(bootdir)header.o $(bootdir)header.S

$(bootdir)bioscall.o: $(bootdir)bioscall.S
	gcc -nostdinc -Iinclude -include include/generated/autoconf.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA   -c -o $(bootdir)bioscall.o $(bootdir)bioscall.S


$(bootdir)main.o: $(bootdir)main.c
	gcc $(gcc_c_flags) -o $(bootdir)main.o $(bootdir)main.c

$(bootdir)tty.o: $(bootdir)tty.c
	gcc $(gcc_c_flags) -o $(bootdir)tty.o $(bootdir)tty.c

$(bootdir)regs.o:$(bootdir)regs.c
	gcc $(gcc_c_flags) -o $(bootdir)regs.o $(bootdir)regs.c

$(bootdir)memory.o:$(bootdir)memory.c
	gcc $(gcc_c_flags) -o $(bootdir)memory.o $(bootdir)memory.c

$(bootdir)mca.o: $(bootdir)mca.c
	gcc $(gcc_c_flags) -o $(bootdir)mca.o $(bootdir)mca.c

$(bootdir)copy.o: $(bootdir)copy.S
	gcc $(gcc_as_flags) -o $(bootdir)copy.o $(bootdir)copy.S

$(bootdir)apm.o: $(bootdir)apm.c
	gcc $(gcc_c_flags) -o $(bootdir)apm.o $(bootdir)apm.c

$(bootdir)cpu.o: $(bootdir)cpu.c
	gcc $(gcc_c_flags) -o $(bootdir)cpu.o $(bootdir)cpu.c

$(bootdir)printf.o: $(bootdir)printf.c
	gcc $(gcc_c_flags) -o $(bootdir)printf.o $(bootdir)printf.c

$(bootdir)cpucheck.o: $(bootdir)cpucheck.c
	gcc $(gcc_c_flags) -o $(bootdir)cpucheck.o $(bootdir)cpucheck.c

$(bootdir)string.o: $(bootdir)string.c
	gcc $(gcc_c_flags) -o $(bootdir)string.o $(bootdir)string.c

$(bootdir)edd.o: $(bootdir)edd.c
	gcc $(gcc_c_flags) -o $(bootdir)edd.o $(bootdir)edd.c

$(bootdir)cmdline.o: $(bootdir)cmdline.c
	gcc $(gcc_c_flags) -o $(bootdir)cmdline.o $(bootdir)cmdline.c

$(bootdir)video.o: $(bootdir)video.c
	gcc $(gcc_c_flags) -o $(bootdir)video.o $(bootdir)video.c

$(bootdir)video-vesa.o: $(bootdir)video-vesa.c
	gcc $(gcc_c_flags) -o $(bootdir)video-vesa.o $(bootdir)video-vesa.c

$(bootdir)video-vga.o: $(bootdir)video-vga.c
	gcc $(gcc_c_flags) -o $(bootdir)video-vga.o $(bootdir)video-vga.c

$(bootdir)video-mode.o: $(bootdir)video-mode.c
	gcc $(gcc_c_flags) -o $(bootdir)video-mode.o $(bootdir)video-mode.c

$(bootdir)video-bios.o: $(bootdir)video-bios.c
	gcc $(gcc_c_flags) -o $(bootdir)video-bios.o $(bootdir)video-bios.c


$(bootdir)pm.o: $(bootdir)pm.c
	gcc $(gcc_c_flags) -o $(bootdir)pm.o $(bootdir)pm.c

$(bootdir)a20.o: $(bootdir)a20.c
	gcc $(gcc_c_flags) -o $(bootdir)a20.o $(bootdir)a20.c

$(bootdir)pmjump.o: $(bootdir)pmjump.S
	gcc $(gcc_as_flags) -o $(bootdir)pmjump.o $(bootdir)pmjump.S






clean:
	rm $(bootdir)pmjump.o $(bootdir)a20.o $(bootdir)pm.o $(bootdir)edd.o $(bootdir)cmdline.o $(bootdir)video.o $(bootdir)video-vesa.o $(bootdir)video-vga.o $(bootdir)video-mode.o $(bootdir)video-bios.o $(bootdir)apm.o $(bootdir)cpu.o $(bootdir)printf.o $(bootdir)cpucheck.o $(bootdir)string.o $(bootdir)mca.o $(bootdir)copy.o $(bootdir)memory.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)main.o $(bootdir)header.o $(bootdir)setup.elf $(bootdir)setup.bin $(bootdir)bzImage
