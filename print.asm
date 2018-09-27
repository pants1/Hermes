print:
	pusha

start:                       ; 'start' function
	mov  al, [bx]            ; Moves the bytes at the front of the bx register into al
	cmp  al, 0               ; Comparing for null terminator
	je   done                ; If the value is equivilent to 0 (null), run 'done'

	mov  ah, 0x0e            ; Enter tty mode and write byte at al register
	int  0x10

	add bx, 1                ; Incriment pointer at bx by 1 and loop
	jmp start                ; Loops until null value is found

done:						 ; 'done' function
	popa
	ret

print_nl:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10
    
    popa
    ret