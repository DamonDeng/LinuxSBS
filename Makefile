bootdir:=arch/x86/boot/

bzImage:$(bootdir)setup.bin $(bootdir)vmlinux.bin
	$(bootdir)/tools/build $(bootdir)setup.bin $(bootdir)vmlinux.bin CURRENT > $(bootdir)bzImage

run:
	qemu -kernel $(bootdir)bzImage

$(bootdir)setup.bin:$(bootdir)setup.elf
	objcopy -O binary $(bootdir)setup.elf $(bootdir)setup.bin

$(bootdir)setup.elf: $(bootdir)header.o $(bootdir)main.o
	ld -m elf_i386 -T $(bootdir)setup.ld $(bootdir)header.o $(bootdir)main.o -o $(bootdir)setup.elf

$(bootdir)header.o: $(bootdir)header.S
	gcc -nostdinc -Iinclude -include include/generated/autoconf.h -D__KERNEL__ -g -Os -D_SETUP -D__KERNEL__ -DDISABLE_BRANCH_PROFILING -Wall -Wstrict-prototypes -march=i386 -mregparm=3 -include ./code16gcc.h -fno-strict-aliasing -fomit-frame-pointer  -ffreestanding  -fno-toplevel-reorder  -fno-stack-protector  -mpreferred-stack-boundary=2  -m32 -D__ASSEMBLY__   -DSVGA_MODE=NORMAL_VGA -Iarch/x86/boot  -c -o $(bootdir)header.o $(bootdir)header.S

$(bootdir)main.o: $(bootdir)main.c
	gcc -c -o $(bootdir)main.o $(bootdir)main.c

clean:
	rm $(bootdir)main.o $(bootdir)header.o $(bootdir)setup.elf $(bootdir)setup.bin $(bootdir)bzImage
