print_string:
push ax
_loop:
;lodsb = mov al, [si]
lodsb ;it also increase the value of si reg.,so no need of add si, 1 instruction;
cmp al,0
je _end

mov ah, 0x0e
;inc si
int 0x10

jmp _loop
_end:
pop ax
ret