;;
;;RENDER SYSTEM
;;

screen_start = 0xC000
backgroun_color = 0x00

;;Initializes the render system by storing a pointer to the first element of the entity array
rendersys_init::
    push af

    ld de, #screen_start
    ld  b, 1(ix)    ;;y
    ld  c, 0(ix)    ;;x
    call cpct_getScreenPtr_asm

    ld 8(ix), h
    ld 7(ix), l

    ld bc, #entity_size
    add ix, bc
    jr _renloop

;;INPUT
;;  IX: Pointer to first entity
;;   A: number of entities to render
rendersys_update::

_renloop:
    push af

    ;; Erase the las sprite position
    ld h, 8(ix)
    ld l, 7(ix)
    ex de, hl
    ld  a, #backgroun_color
    ld  b, 3(ix)    ;;w
    ld  c, 2(ix)    ;;H
    call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead


    ;; Draw the new sprite and store the new position
    ld de, #screen_start
    ld  b, 1(ix)    ;;y
    ld  c, 0(ix)    ;;x
    call cpct_getScreenPtr_asm
    ld 8(ix), h
    ld 7(ix), l
    ex de, hl
    ld  a, 6(ix)
    ld  b, 3(ix)    ;;w
    ld  c, 2(ix)    ;;H
    call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead

    pop af

    dec a
    ret z

    ld bc, #entity_size
    add ix, bc
    jr _renloop