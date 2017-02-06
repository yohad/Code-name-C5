section _text
global start

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
	mov 	cx, 0xCCCC
	movsw

imp:

	movsw
	movsw
	movsw
	mov  	word [di+0x70], cx    	;Bomb location
	movsw
	movsw
	xor 	si, si					;make si point to begining of private location
	movsw

exit:
