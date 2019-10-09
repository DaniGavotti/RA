;;
;;PHYSICS SYSTEM
;;

.include "entity_manager.h.s"
.include "physics_system.h.s"

;; Updates the position of entities by adding their speed to their position
;;  IX: Pointer to first entity
;;   A: number of entities to update

phy_update::

_phyloop:
    push af

    ;;Updates y
    ld a, #screen_heigth + 1
	sub e_h(ix)
	ld c, a

    ;;Apply gravity
    ld a, e_vy(ix)
    add #gravity
    ld e_vy(ix), a

    ld  a, e_y(ix)    ;;y
    add e_vy(ix)
    cp c

    jr nc, _invalid_y

_valid_y:
    ld  e_y(ix), a
    jr _endif_y

_invalid_y:
    ld a, e_vy(ix)
    ld e_state(ix), #0
    ld e_vy(ix), #0

_endif_y:

    ;;Updates x
    ld a, #screen_width + 1
	sub e_w(ix)
	ld c, a


    ld  a, e_x(ix)    ;;x
    add e_vx(ix)
    cp c

    jr nc, _invalid_x

_valid_x:
    ld  e_x(ix), a
    jr _endif_x

_invalid_x:
    ld a, e_vx(ix)
    neg
    ld e_vx(ix), a

_endif_x:


    pop af

    dec a
    ret z

    ld bc, #entity_size
    add ix, bc
    jr _phyloop
