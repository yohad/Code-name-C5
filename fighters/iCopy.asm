section .text
global _start

_start:

    push    ax
    mov     si, ax

    mov     cx, 0x400 - (_exit - _trap)
    mov     ax, 0x9090
    rep     stosw

    add     si, (_trap - _start)
    mov     cx, (_exit - _trap)
    rep     movsw

    push    es
    push    ds
    pop     es
    pop     ds

    pop     di
    add     di, (_exit - _start)

    jmp     _main

_trap:

    std
    mov     ax, 0x9090
    mov     cx, 0x200
    rep     stosw
    int     0x3

_main:

    xor     si, si
    mov     cx, 0x400
    rep     movsw
    add     di, 0x400
    db      0xE9
    db      0xFD
    db      0x03

_exit: