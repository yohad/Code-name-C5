IDEAL
model tiny
CODESEG
org 100h
start:
	mov bx, ax
	add bx, (exit - start)
	mov ax, 20h
trap:
		;;;TRAP;;;
		;mov bx, {IP of trap}
		;add bx, 8000
		;mov byte ptr [bx], 0CCh
		;int 3
		;;;END;;;
	add bx, ax
		;mov bx, {location of trap start}
	mov [byte bx], 0BBh
	mov [word bx+1], bx
		;add bx, 8000 --To get to the other side of the arena
	mov [word bx+3], 81C3h
	mov [word bx+5], 8000h
		;mov byte ptr [bx], 0CCh
	mov [word bx+7], 0C607h
	mov [byte bx+8], 0CCh
		;kill the poor soul
	mov [byte bx+9], 0CCh
	add ax, ax
	neg ax
	jmp trap
exit:
END start