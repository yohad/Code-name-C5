section _text
global start
LENGTH_CHECK 	equ 0x70
SCAN_LENGTH		equ 0x79
SCANBRANCH_LENGTH 	equ 128

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
	mov 	cx, SCAN_LENGTH
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
	movsw
	shl ax, 3

	movsw
	movsw
	add 	si, ax

	movsw							; post-comparison load

scan:

	movsw
	mov 	al, 0xA5

	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	push 	di						; This is used to jump to the movsw later.
	push 	si
	push 	di
	repne 	scasb
	pop 	si
	pop 	di

	movsw
	push 	cx

	movsw
	movsw
	neg		cx

	movsw
	movsw
	shl 	cx, 1

	movsw
	movsw
	xor 	ax, ax

	movsw
	movsw
	adc		al, 0

	movsw
	movsw
	xchg	al, ah

	movsw
	movsw
	add 	si, ax
	movsb							; Load next branch

no_movsw_found:
	movsw
	movsw
	pop 	ax						; Restore the stack to its previous state.
	pop		ax

	movsw
	movsw
	xor 	si, si
	movsw

movsw_found:
	movsw
	movsw
	pop 	cx
	pop 	ax 						; Start of scan address is stored in AX

	movsw
	movsw
	neg		cx

	movsw
	movsw
	movsw
	add		cx, SCAN_LENGTH-1

	movsw
	movsw
	add 	cx, ax

	movsw
	movsw
	movsw
	movsw
	movsw
	movsw
	mov		di, cx
	inc		di
	xor 	si, si
	jmp 	cx
scanbranch_end:
	times	(SCANBRANCH_LENGTH - scanbranch_end + scan) db	0x90	; Padding

	movsw
	xor si, si
	movsw

; 	movsw
; post_scan:
; 	movsw
; 	xor 	si, si
; 	movsw
exit:
