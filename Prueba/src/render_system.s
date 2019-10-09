;;
;;RENDER SYSTEM
;;

.include "entity_manager.h.s"
.include "render_system.h.s"
.include "physics_system.h.s"


screen_start = 0xC000
backgroun_color = 0x00


rendersys_Wipe::
    ;; Erase the las sprite position
    ld h, #0xC0
    ld l, #0x00
    ex de, hl
    ld  a, #backgroun_color
    ld  b, #screen_width    ;;w
    ld  c, #screen_heigth    ;;H
    call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead


;;Initializes the render system by storing a pointer to the first element of the entity array
rendersys_init::
    push af

    ld de, #screen_start
    ld  b, e_y(ix)    ;;y
    ld  c, e_x(ix)    ;;x
    call cpct_getScreenPtr_asm

    ld e_lp_h(ix), h
    ld e_lp_l(ix), l

    pop af
    dec a
    ret z

    ld bc, #entity_size
    add ix, bc

    jr rendersys_init

;;INPUT
;;  IX: Pointer to first entity
;;   A: number of entities to render
rendersys_update::

_renloop:
    push af

    ;; Erase the las sprite position
    ld h, e_lp_h(ix)
    ld l, e_lp_l(ix)
    ex de, hl
    ld  a, #backgroun_color
    ld  b, e_h(ix)    ;;w
    ld  c, e_w(ix)    ;;H
    call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead


    ;; Draw the new sprite and store the new position
    ld de, #screen_start
    ld  b, e_y(ix)    ;;y
    ld  c, e_x(ix)    ;;x
    call cpct_getScreenPtr_asm
    ld e_lp_h(ix), h
    ld e_lp_l(ix), l
    ex de, hl
    ;;ld  h, e_sprite(ix)
    ;;ld  l, e_sprite_l(ix)
    ld a, e_sprite(ix)
    ld  b, e_h(ix)    ;;w
    ld  c, e_w(ix)    ;;H
    call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead


    pop af

    dec a
    ret z

    ld bc, #entity_size
    add ix, bc
    jr _renloop
