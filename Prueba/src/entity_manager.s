;;
;;          ENTITY MANAGER
;;

.include "cpctelera.h.s"
.include "entity_manager.h.s"

.area _CODE

max_entities = 3
entity_size  == 11

_entity_num: .db 0 
_entity_pend: .dw _entity_array
_entity_array: 
DefineEntityArray _entity_array, max_entities

;;
;;          GET ARRAY
;;
man_entity_getArray::
    ld ix, #_entity_array
    ld a, (_entity_num)
    ret

;;
;;          INIT
;;
man_entity_init::
    xor a
    ld (_entity_num), a

    ld hl, #_entity_array
    ld (_entity_pend), hl

    ret

;;
;;          NEW ENTITY
;;
man_entity_new::
    ld hl, #_entity_num
    inc (hl)

    ld hl, (_entity_pend)
    ld d, h
    ld e, l
    ld bc, #entity_size
    add hl, bc
    ld (_entity_pend), hl

    ret

;;
;;          CREATE ENTITY
;;
man_entity_create::
    push hl
    call man_entity_new

    ld__ixh_d
    ld__ixl_e

    pop hl
    ldir

    ret

