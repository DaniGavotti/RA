
.macro DefineEntity _name, _x, _y, _h, _w, _vx, _vy , _sprite, _lastPosPtr, _state
    _name:
        .db _x
        .db _y
        .db _h
        .db _w
        .db _vx
        .db _vy
        .db _sprite
        .dw _lastPosPtr
        .db _state
.endm

e_x=0
e_y=1
e_h=2
e_w=3
e_vx=4
e_vy=5
e_sprite=6
e_lp_l = 7
e_lp_h = 8
e_state = 9
sizeof_e= 10


;;states
standing = 0
jumping = 1
crouched = 2


.macro DefineEntityDefault _name, _n
    DefineEntity _name'_n, #0, #0, #0, #0, #0, #0, #0, #0, #0
.endm

.macro DefineEntityArray _name, _N
    _c = 0
    .rept _N
        DefineEntityDefault _name, \_c
        _c= _c + 1
    .endm
.endm

.globl man_entity_getArray
.globl man_entity_create
.globl entity_size
.globl man_entity_init
