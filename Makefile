

buildAll:copyintoDisk

run:
	qemu -fda ./harddisk.img

copyintoDisk:createDisk copyobject
	dd status=noxfer conv=notrunc if=arch/x86/boot/header.bin of=harddisk.img

copyobject:linkfile
	objcopy  -O binary -R .note -R .comment -S arch/x86/boot/header arch/x86/boot/header.bin

createDisk:
	qemu-img create -f raw harddisk.img 10M

linkfile:buildfile
	ld -T arch/x86/boot/header.ld arch/x86/boot/header.o -o arch/x86/boot/header

buildfile:arch/x86/boot/header.S
	gcc -nostdinc -isystem -D__KERNEL__ -m32 -D__KERNEL__  -O2 -fno-strict-aliasing -fPIC -DDISABLE_BRANCH_PROFILING -march=i386 -ffreestanding -fno-stack-protector -D__ASSEMBLY__ -c -o arch/x86/boot/header.o arch/x86/boot/header.S

clean:
	rm harddisk.img arch/x86/boot/header.bin arch/x86/boot/header.o arch/x86/boot/header



