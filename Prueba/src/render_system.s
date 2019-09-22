;;
;;RENDER SYSTEM
;;

rendersys_init::

;;INPUT
;;  IX: Pointer to first entity
;;   A: number of entities to render
rendersys_update::

_renloop:
    push af

    ld de, #0xC000
    ld  b, 1(ix)    ;;y
    ld  c, 0(ix)    ;;x
    call cpct_getScreenPtr_asm

    ex de, hl
    ld  a, 6(ix)
    ld  b, 3(ix)    ;;w
    ld  c, 2(ix)    ;;H
    call cpct_drawSolidBox_asm

    pop af

    dec a
    ret z

    ld bc, #entity_size
    add ix, bc
    jr _renloop