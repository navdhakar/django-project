this is os containing boot loader and kernel.
currently working on drivers--*screen_____
install qemu--emulator
to run in terminal

:$-make
:$-make run
using make file or alter makefile according to your specification.
or run by follownig commands:-
assembler--                           $-nasm -f bin boot_sect.asm -o boot_sect.bin
compile kernel--                      $-gcc -fno-pie -c kernel.c -o kernel.o -m32 
link kernel--                         $-ld -o kernel.bin -Ttext 0x7e00 kernel.o -m elf_i386 --oformat binary 
concate boot_sect && kernel.bin--     $-cat boot_sect.bin kernel.bin > os_image.bin 
run in emulator--                     $-qemu-system-x86_64 os_image.bin
