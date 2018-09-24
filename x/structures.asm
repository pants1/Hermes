[org 0x7c00]                 ; memory offset

mov  bx, STRING_HELLO        ; Moving address of data into bx register
call print

jmp $

%include "print.asm"

STRING_HELLO:
	db 'Hello, world!', 0    ; 0x00 null byte

times 510-($-$$) db 0        ; Writes bootable bin
dw 0xaa55