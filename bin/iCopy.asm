section .text
global _start

_start:

    push    ax
    mov     si, ax

    mov     cx, (0x400 - (_exit - _trap)) / 2
    mov     ax, 0x9090
    rep     stosw

    add     si, (_trap - _start)
    mov     cx, (_exit - _trap) / 2
    rep     movsw

    push    es
    push    ds
    pop     es
    pop     ds

    pop     di
    add     di, (_exit - _start)

    jmp     _main

_trap:

    nop
    std
    push    es
    push    ds
    pop     es
    pop     ds
    mov     ax, 0x9090
    mov     cx, 0x200
    rep     stosw
    int     0x3

_main:

    xor     si, si
    mov     cx, 0x200
    rep     movsw
    ; add     di, 0x400
    jmp     _main + 0x400

_exit: