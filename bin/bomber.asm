IDEAL
MODEL tiny
CODESEG
org 100h
start:
	mov bx, ax
	add bx, (start-exit)
	mov cx, 20h
	mov dx, bx
bomb:
	mov [byte bx], 0CCh
	add bx, cx
	cmp bx, dx
	jne bomb
	shr cx, 1
	jmp bomb
exit:
END start