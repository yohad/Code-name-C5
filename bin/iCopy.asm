section .text
global _start

_start:

    mov     bx, ax
    add     bx, (_exit - start)
    ;Load the acopier to ES
    mov     si, _copier
    mov     cx, (_trap - _copier) / 2
    rep     movsw
    ;Load NOPs untill the trap to ES
    mov     ax, 9090
    mov     cx, (1024 - (_exit - _copier)) / 2
    rep     stosw
    ;Load trap to ES
    mov     si, _trap
    mov     cx, (_exit - _trap) / 2
    rep     movsw
    ;Replace ES and DS to copy from ES to the arena
    push    es
    push    ds
    pop     es
    pop     ds
    ;Set direction flag for reverse copying
    std

    mov     di, bx

_copier:

    mov     si, 1024
    add     di, 1024
    mov     cx, 512
    rep     movsw
    dw      0xE9FD ;jmp relative to +1024 bytes
    db      0x03

_trap:

    std
    mov     ax, 0xFACC
    mov     cx, 512 
    rep     stosw

_exit:
