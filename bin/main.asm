IDEAL
model tiny
CODESEG
org 100h

TRAP_SRC equ 0		; The location in shared memory where the trap is stored.
TRAP_SIZE equ trap_data_end - trap_data	; The size of the trap in bytes.

start:
	mov di, 0		; This block stores the trap instructions in private memory.
	mov si, offset trap_data
	mov cx, TRAP_SIZE
	rep movsb 
	
	mov di, ax
	add di, (exit - start)
	mov dx, 19h
	
	;;;TRAP;;;
	;mov bx, {IP of trap}
	;add bx, 8000h
	;mov byte ptr [bx], 0CCh
	;int 3
	;;;END;;;

trap:
	xor si, si	; Prepares to move the trap contents from ds:[0 -> 10] to es:[di -> di+10]
	add di, dx
	mov ax, di
	mov di, TRAP_SRC + 1
	stosw
	mov di, ax
	;mov bx, {location of trap start}
	; Updates the trap code to use the current trap's starting address.
		
	push ds
	push es
	pop ds
	pop es	; DS and ES must be swapped for movs to copy private memory to public memory.

	mov cx, TRAP_SIZE
	rep movsb
	sub di, TRAP_SIZE
	
	push ds
	push es
	pop ds
	pop es

	mov ax, dx
	add ax, ax
	add dx, ax
	neg dx

	jmp trap
exit:
trap_data:
	mov bx, 1111h	; Placeholder data
	add bx, 8000h
	mov [byte ptr bx], 0CCh
	int 3
trap_data_end:
END start
