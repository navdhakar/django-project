print_hex:
mov si, HEX_TEMPLATE

mov bx, dx ;bx ->0x1234
shr bx, 12 ; shift 1 to 4th pos. bx ->0x0001
mov bx, [bx+HEXABET]
mov [HEX_TEMPLATE+2], bl

mov bx, dx ;bx ->0x1234
shr bx, 8 ; bx ->0x0012
and bx, 0x000f ;bx-->0x0002
mov bx, [bx+HEXABET]
mov [HEX_TEMPLATE+3], bl

mov bx, dx ;bx ->0x1234
shr bx, 4 ;  bx ->0x00123
and bx, 0x000f ;bx->0x0003
mov bx, [bx+HEXABET]
mov [HEX_TEMPLATE+4], bl

mov bx, dx ;bx ->0x1234 
and bx, 0x000f ;bx->0x0003
mov bx, [bx+HEXABET]
mov [HEX_TEMPLATE+5], bl

call print_string
ret