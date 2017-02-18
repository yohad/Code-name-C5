section _text
global start
LENGTH_CHECK 	equ 0x50

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
	mov 	dx, es 					; dx points to code/data segment
	mov 	bx, ds 					; bx points to private memory
	mov 	bp, 0x10

	movsw
imp:
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	mov 	ds, dx
	mov 	ax, [di+LENGTH_CHECK]
	mov 	ds,bx

	movsw
	movsw
	not 	ax

	movsw
	movsw
	and 	ax, bp

	movsw
	movsw
	add 	si, ax

	movsw							; post-comparison load

bomb:
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	mov 	ds, dx
	mov 	[di + LENGTH_CHECK+6], cx		; bomb
	mov 	ds, bx

	movsb
	movsb
	movsw
postbomb:
	movsw
	xor 	si, si
	movsw
exit:
