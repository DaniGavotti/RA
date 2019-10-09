ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2 .macro DefineEntity _name, _x, _y, _h, _w, _vx, _vy , _sprite, _lastPosPtr, _state
                              3     _name:
                              4         .db _x
                              5         .db _y
                              6         .db _h
                              7         .db _w
                              8         .db _vx
                              9         .db _vy
                             10         .db _sprite
                             11         .dw _lastPosPtr
                             12         .db _state
                             13 .endm
                             14 
                     0000    15 e_x=0
                     0001    16 e_y=1
                     0002    17 e_h=2
                     0003    18 e_w=3
                     0004    19 e_vx=4
                     0005    20 e_vy=5
                     0006    21 e_sprite=6
                     0007    22 e_lp_l = 7
                     0008    23 e_lp_h = 8
                     0009    24 e_state = 9
                     000A    25 sizeof_e= 10
                             26 
                             27 .macro DefineEntityDefault _name, _n
                             28     DefineEntity _name'_n, #0, #0, #0, #0, #0, #0, #0, #0, #0
                             29 .endm
                             30 
                             31 .macro DefineEntityArray _name, _N
                             32     _c = 0
                             33     .rept _N
                             34         DefineEntityDefault _name, \_c
                             35         _c= _c + 1
                             36     .endm
                             37 .endm
                             38 
                             39 .globl man_entity_getArray
                             40 .globl man_entity_create
                             41 .globl entity_size
                             42 .globl man_entity_init
