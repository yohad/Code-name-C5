IDEAL
MODEL tiny
CODESEG
org 100h
start:
	mov bx, ax
	add bx, (exit-start)
	mov ax, 4000h
	mov dx, bx
bomb:
	add bx, ax
	mov [word bx], 0CCCCh
	cmp cx, dx
	jne bomb
	shr ax, 1
	jmp bomb
exit:
END start