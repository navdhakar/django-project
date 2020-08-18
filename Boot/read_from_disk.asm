read_from_disk:
  pusha 
  
  mov ah, 0x02 ;read sector from drive
  ;mov al, 1 ;no. sector to read
  mov ch, 0 ;select first cylinder
  mov dh, 0 ;select the first read/write head
  mov cl, 2 ;selct second sector
  
  push bx
  mov bx, 0
  mov es, bx;es->0
 ; mov bx, 0x7c00 + 512
  pop bx
int 0x13

jc disk_read_error ;jump to read error if there is CF/carry flag

popa
ret

disk_read_error:
mov si, DISK_ERROR
call print_string
jmp $
DISK_ERROR:db 'Error in reading disk',0