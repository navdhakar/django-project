[org 0x7c00]
mov bp, 0xffff
mov sp, bp

mov si, MSG_REAL_MODE
call print_string

mov si, MSG_LOADING_KERNEL
call print_string

mov al, 9
mov bx, 0x7e00
call read_from_disk
call switch_to_pm

jmp $   ;hang cpu

%include "Boot/print_string.asm"
;%include "print_hex.asm"
%include "Boot/read_from_disk.asm"
%include "Boot/switch_to_pm.asm"
%include "Boot/print_string_pm.asm"

[bits 32]

BEGIN_PM:
;0xb8000 video memory location
;mov esi, MSG_PROT_MODE
;call print_string_pm
jmp kernel_entry
jmp $

[bits 16]
;HEX_TEMPLATE: db '0x???? ', 0
;HEXABET:db '0123456789abcdef'
;specs: db '**VISOS*** loaded memory = 512 bytes only 1_sector', 0
;DISK_ERROR:db 'error reading disk sector', 0
MSG_REAL_MODE: db 'started in 16 bit mode.....', 0
MSG_LOADING_KERNEL: db 'loading kernel from disk to adress 0x7e00',0
MSG_PROT_MODE: db 'successfully switched into 32 bit mode', 0
times 510-($-$$) db 0
dw 0xaa55
kernel_entry:
;disk: db 'i m alien loc-> disk_drive=0x02, head=0, cylinder=1',0
;times 512 db 0