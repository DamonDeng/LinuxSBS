bootdir:=arch/x86/boot/

gcc_c_flags:=-nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -include $(bootdir)boot.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -ffreestanding -fno-toplevel-reorder -fno-stack-protector -mpreferred-stack-boundary=2 -m32 -c

gcc_as_flags:=-nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude  -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA   -c


bzImage:$(bootdir)setup.bin $(bootdir)vmlinux.bin
	$(bootdir)/tools/build $(bootdir)setup.bin $(bootdir)vmlinux.bin CURRENT > $(bootdir)bzImage

run:
	qemu -kernel $(bootdir)bzImage

$(bootdir)setup.bin:$(bootdir)setup.elf
	objcopy -O binary $(bootdir)setup.elf $(bootdir)setup.bin

$(bootdir)setup.elf: $(bootdir)header.o $(bootdir)main.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)memory.o $(bootdir)mca.o $(bootdir)copy.o $(bootdir)apm.o $(bootdir)cpu.o $(bootdir)printf.o $(bootdir)cpucheck.o $(bootdir)string.o              
	ld -m elf_i386 -T $(bootdir)setup.ld $(bootdir)header.o $(bootdir)main.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)memory.o $(bootdir)mca.o $(bootdir)copy.o $(bootdir)apm.o $(bootdir)cpu.o $(bootdir)printf.o $(bootdir)cpucheck.o $(bootdir)string.o -o $(bootdir)setup.elf

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




clean:
	rm $(bootdir)apm.o $(bootdir)cpu.o $(bootdir)printf.o $(bootdir)cpucheck.o $(bootdir)string.o $(bootdir)mca.o $(bootdir)copy.o $(bootdir)memory.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)main.o $(bootdir)header.o $(bootdir)setup.elf $(bootdir)setup.bin $(bootdir)bzImage
