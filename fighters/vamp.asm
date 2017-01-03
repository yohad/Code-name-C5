section .text
global _start

INTERVAL equ 4

_start:
	mov di, ax
	mov bx, ax
	add di, (fang - _start)
	add bx, (pit - _start)
	mov [di + 1], bx	; Arming fang
	mov si, di
	add di, (pit - fang)
	mov [di + 1], di
	add word [di + 1], (exit - pit)	; Activating pit
	add di, (exit - pit)

	push ds
	pop es
	
	; END OF SETUP
	; DI = abs(exit)
	; SI = abs(fang)
	; ES = DS
	
fangtoss:
	mov cx, (pit - fang)
	rep movsb
	sub si, (pit - fang)
	add di, INTERVAL
	jmp fangtoss
	
padding:		; TODO add padding.
fang:
	mov ax, 0	; 0 will be replaced with the pit's location during runtime.
	push ax
	ret
pit:
	mov di, 0	; Placeholder value. Will be changed to the pit's _starting location at runtime.
	mov cx, 0FFFFh - (exit - _start) ; The size of the board minus the size of the entire vampire (including the pit).
	mov ax, 0CCCCh		       ; Arm missiles.
	rep stosw		       ; Core-clear
	int 0x3			       ; Self destruct

exit:
