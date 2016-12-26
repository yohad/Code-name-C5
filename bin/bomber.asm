section		.text
global		_start

_start:

	mov 	bx, ax
	add 	bx, (_start-_exit)
	mov 	cx, 20h
	mov 	dx, bx

_bomb:

	mov 	byte [bx], 0CCh
	add 	bx, cx
	cmp 	bx, dx
	jne 	_bomb
	shr 	cx, 1
	jmp 	_bomb

_exit: