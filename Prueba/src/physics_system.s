;;
;;PHYSICS SYSTEM
;;

;; Updates the position of entities by adding their speed to their position
;;  IX: Pointer to first entity
;;   A: number of entities to update

phy_update::

_phyloop:
    push af

    ;;Updates y
    ld  a, 1(ix)    ;;y
    add 5(ix)
    ld  1(ix), a

    ;;Updates x
    ld  a, 0(ix)    ;;x
    add 4(ix)
    ld  0(ix), a

    pop af

    dec a
    ret z

    ld bc, #entity_size
    add ix, bc
    jr _phyloop
