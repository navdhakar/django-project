 C_SOURCES  = $(wildcard kernel/*.c drivers/*.c)
 HEADERS = $(wildcard kernel/*.h driver/*.h)
 ASM = $(wildcard Boot/*.asm)


OBJ = ${C_SOURCES:.c=.o}
BIN = $(ASM:.asm=.bin}

all:os_image.bin
run:all
	qemu-system-x86_64 os_image.bin

os_image.bin:boot_sect.bin kernel.bin
	cat boot_sect.bin kernel.bin > os_image.bin

truncing: kernel.bin
	truncate $< -s 5120

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x7e00 $^ -m elf_i386 --oformat binary

kernel/kernel_entry.o:kernel/kernel_entry.asm
	nasm $< -f elf -o $@

boot_sect.bin: Boot/boot_sect.asm
	nasm -f bin $< -o $@

%.o : %.c ${HEADERS}
	gcc -fno-pie -c $< -o $@ -m32


%.bin : %.asm
	nasm -f bin $< -o $@

clean:
	rm -fr *.bin *.dis *.o os_image.bin
	rm -fr kernel/*.o Boot/*.bin drivers/*.o kernel/*.bin
