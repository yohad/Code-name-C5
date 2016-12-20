IDEAL
model tiny
CODESEG
org 100h

TRAP_SRC equ 0		; The start address in private memory where the trap is stored.
TRAP_SIZE equ 11	; The size of the trap in decimal.

start:
	mov di, ax
	add di, (exit - start)
	mov ax, 20h

	mov [byte ptr es:TRAP_SRC], 0BBh
	mov [word ptr es:TRAP_SRC + 1], 0000h	; Placeholder. Each time the trap is placed this value needs to be changed to the current trap's IP.
	mov [word ptr es:TRAP_SRC + 3], 81C3h
	mov [word ptr es:TRAP_SRC + 5], 8000h
	mov [word ptr es:TRAP_SRC + 7], 0C607h
	mov [word ptr es:TRAP_SRC + 9], 0CCCCh

	;;;TRAP;;;
	;mov bx, {IP of trap}
	;add bx, 8000h
	;mov byte ptr [bx], 0CCh
	;int 3
	;;;END;;;

	push ds
	push es
	pop ds
	pop es	; DS and ES must be swapped for movs to copy private memory to public memory.
trap:
	xor si, si	; Prepares to move the trap contents from ds:[0 -> 10] to es:[di -> di+10]
	add di, ax
	mov ds:[1], di
	;mov bx, {location of trap start}
	; Updates the trap code to use the current trap's starting address.
	
	mov cx, TRAP_SIZE
	rep movsb

	add ax, ax
	neg ax
	jmp trap
exit:
END start
