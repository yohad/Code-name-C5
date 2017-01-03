section .text
global _start

_start:

    mov     si, ax
    add     si, (_exit - _main)
    mov     cx, (_exit - _main) / 2
    rep     movsw

    std
    push    es
    push    ds
    pop     es
    pop     ds
    mov     di, _start

_main:

    mov     si, 0x400
    mov     cx, 0x200
    rep     movsw
    sub     di, (_main - _start)
    jmp     _start - 0x400

_exit: