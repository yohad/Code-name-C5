section .text
global _start

_start:

    mov     si, ax
    add     si, (_main - _start) - 2
    mov     cx, (_exit - _main) / 2 + 2

    rep     movsw

    std
    push    es
    push    ds
    pop     es
    pop     ds

    mov     di, ax
    jmp     _run

_main:

    int     0x3

_run:

    mov     si, 0x400
    mov     cx, 0x200
    rep     movsw
    sub     di, _main - _start
    jmp     _run - 0x400 - (_main - _start) + 1

_exit: