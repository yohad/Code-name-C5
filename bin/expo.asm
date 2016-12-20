IDEAL
MODEL tiny
CODESEG
org 100h
start:
	mov 	bx, ax
	add		bx, (exit-start)
	mov		ax, 20h
	mov 	cx, ax
bomb:
	add 	bx, ax
	mov 	[byte bx], 0CCh
	add		ax, ax
	neg 	ax
	jnz	 	bomb
	inc		cx
	add 	ax, cx
	jmp 	bomb
exit:
END start