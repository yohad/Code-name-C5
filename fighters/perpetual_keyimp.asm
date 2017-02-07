section _text
global start
JUMP_INTERVAL equ 20
KEY equ 0x4C

start:

	mov 	si, ax					;mov si, the location of the code
	add 	si, (imp - start)		;make si point to the start of the imp
	mov 	cx, (exit - imp)    	;put in cx number for rep (divided by 2 for word action)
	rep 	movsb					;load to private memory the imp code

	push 	es						;exchange es and ds values for copying from private memory
	push 	ds
	pop 	es
	pop 	ds

	mov 	di, ax					;di points to start
	add 	di, (imp - start)		;di points to imp
	xor 	si, si
	mov 	cx, KEY
	mov dx, es ; ax points to code/data segment
	mov bx, ds ; bx points to private memory
	mov ax, JUMP_INTERVAL
	movsw
	movsw

imp:

	movsw
	movsw
	movsw
	movsw

	cmp cx, KEY
	je not_dead	; Jump one forward to skip the trap if the key is valid
	db 0xCC
	not_dead:
	movsw

	movsw
	movsw
	movsw
	add di, ax
	movsb
	db 0xEB, JUMP_INTERVAL

	movsw
	movsw
	movsw

	xor 	si, si					;make si point to begining of private location
	movsw
	movsw

exit:
