mov  ah, 0x0e     ; tty mode in eax a-higher 

mov  bp, 0x8000   ; this is an address far away from 0x7c00 so that we don't get overwritten
mov  sp, bp       ; if the stack is empty then sp points to bp

                  ;  Stack
push 'A'          ;  | A | <- sp  0x7ffe
push 'B'          ;  | B |
push 'C'          ;  | C | <- bp  0x8000

mov  al, [0x7ffe] ; To show how the stack grows downwards. 0x7ffe = 0x8000 - 2
int  0x10         ; Print to console interupt from al -- prints A

mov  al, [0x8000] ; [0x8000] will not work as it is not located at the top of the stack.
int  0x10         ; you can only access the stack top so, at this point, only 0x7ffe (see above)

pop  bx           ; recover our characters using the standard procedure: 'pop'
mov  al, bl       ; We can only pop full words so we need an auxiliary register to manipulate
int  0x10         ; the lower byte -- prints C
                  ; Popping bx places the result in bl

                  ;  Stack
                  ;  | A | <- sp  0x7ffe
                  ;  | B | <-     0x7fff

mov  al, [0x7ffe] ; Prints A
int  0x10

pop  bx
mov  al, bl
int  0x10         ; Prints B

mov  al, [0x7ffe] ;  Stack
int  0x10         ;  | A | <- sp  0x7ffe
                  ; Prints A

pop bx
mov al, bl        ; No more characters on the stack
int 0x10          ; Prints A

mov al, [0x8000]  ; data that has been pop'd from the stack is garbage now
int 0x10


jmp $             ; Writes bootable bin
times 510-($-$$) db 0
dw 0xaa55