bootdir:=arch/x86/boot/

bzImage:$(bootdir)setup.bin $(bootdir)vmlinux.bin
	$(bootdir)/tools/build $(bootdir)setup.bin $(bootdir)vmlinux.bin CURRENT > $(bootdir)bzImage

run:
	qemu -kernel $(bootdir)bzImage

$(bootdir)setup.bin:$(bootdir)setup.elf
	objcopy -O binary $(bootdir)setup.elf $(bootdir)setup.bin

$(bootdir)setup.elf: $(bootdir)header.o $(bootdir)main.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)memory.o
	ld -m elf_i386 -T $(bootdir)setup.ld $(bootdir)header.o $(bootdir)main.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)memory.o -o $(bootdir)setup.elf

$(bootdir)header.o: $(bootdir)header.S
	gcc -nostdinc -Iinclude -include include/generated/autoconf.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -include ./code16gcc.h -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA -Iarch/x86/boot  -c -o $(bootdir)header.o $(bootdir)header.S

$(bootdir)main.o: $(bootdir)main.c
	gcc -nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude  -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3  -fno-strict-aliasing -fomit-frame-pointer -ffreestanding -fno-toplevel-reorder -fno-stack-protector -mpreferred-stack-boundary=2 -m32 -c -o $(bootdir)main.o $(bootdir)main.c

$(bootdir)tty.o: $(bootdir)tty.c
	gcc -nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -include $(bootdir)boot.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -ffreestanding -fno-toplevel-reorder -fno-stack-protector -mpreferred-stack-boundary=2 -m32 -c -o $(bootdir)tty.o $(bootdir)tty.c

$(bootdir)bioscall.o: $(bootdir)bioscall.S
	gcc -nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude  -include include/generated/autoconf.h -include $(bootdir)code16gcc.h  -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA   -c -o $(bootdir)bioscall.o $(bootdir)bioscall.S

$(bootdir)regs.o:$(bootdir)regs.c
	gcc -nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -include $(bootdir)boot.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -ffreestanding -fno-toplevel-reorder -fno-stack-protector -mpreferred-stack-boundary=2 -m32 -c -o $(bootdir)regs.o $(bootdir)regs.c

$(bootdir)memory.o:$(bootdir)memory.c
	gcc -nostdinc -isystem /usr/lib/gcc/i686-linux-gnu/4.6.1/include -Iinclude -include include/generated/autoconf.h -include $(bootdir)code16gcc.h -include $(bootdir)boot.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -fno-strict-aliasing -fomit-frame-pointer -ffreestanding -fno-toplevel-reorder -fno-stack-protector -mpreferred-stack-boundary=2 -m32 -c -o $(bootdir)memory.o $(bootdir)memory.c


clean:
	rm $(bootdir)memory.o $(bootdir)tty.o $(bootdir)bioscall.o $(bootdir)regs.o $(bootdir)main.o $(bootdir)header.o $(bootdir)setup.elf $(bootdir)setup.bin $(bootdir)bzImage
