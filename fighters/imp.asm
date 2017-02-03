section _text
global start

JMPLEN equ 0x83

start:

	mov 	si, ax					;mov si, the location of the code
	add 	si, (imp - start)		;make si point to the start of the imp
	mov 	cx, (exit - imp) / 2	;put in cx number for rep (divided by 2 for word action)
	rep 	movsw					;load to private memory the imp code

	push 	es						;exchange es and ds values for copying from private memory
	push 	ds
	pop 	es
	pop 	ds

	mov 	dx, 0xDEAD				;secret key for not dying as imp
	mov 	di, ax					;di points to start
	add 	di, (imp - start)		;di points to imp

imp:
	
	nop 							;This nop operation makes copying easier
	xor		si, si					;point si to the start of the imp code in private memory
	add 	di, JMPLEN				;di is pointing at the next point
	mov 	cx, (exit - imp) / 2	;number of times to copy word data
	rep 	movsw					;dump new imp to it's new location
	sub 	di, (exit - imp)		;make di point to imp again (from exit)

	cmp 	dx, 0xDEAD				;check dx for authentication
	jz		imp	+ JMPLEN			;jmp to the new imp
	int 	0x3						;kill the non authenticate survivor

exit: