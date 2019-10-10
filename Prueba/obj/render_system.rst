ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              5 .include "entity_manager.h.s"
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
                             27 
                             28 ;;states
                     0000    29 standing = 0
                     0001    30 jumping = 1
                     0002    31 crouched = 2
                             32 
                             33 
                             34 .macro DefineEntityDefault _name, _n
                             35     DefineEntity _name'_n, #0, #0, #0, #0, #0, #0, #0, #0, #0
                             36 .endm
                             37 
                             38 .macro DefineEntityArray _name, _N
                             39     _c = 0
                             40     .rept _N
                             41         DefineEntityDefault _name, \_c
                             42         _c= _c + 1
                             43     .endm
                             44 .endm
                             45 
                             46 .globl man_entity_getArray
                             47 .globl man_entity_create
                             48 .globl entity_size
                             49 .globl man_entity_init
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              6 .include "render_system.h.s"
                              1 ;;
                              2 ;;Render System .h
                              3 ;;
                              4 
                              5 .globl rendersys_Wipe
                              6 .globl rendersys_init
                              7 .globl rendersys_update
                              8 .globl cpct_getScreenPtr_asm
                              9 .globl cpct_drawSolidBox_asm
                             10 .globl cpct_zx7b_decrunch_s_asm
                             11 .globl cpct_drawSprite_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              7 .include "physics_system.h.s"
                              1 ;;
                              2 ;;Physics.h.s
                              3 ;;
                              4 
                     0050     5 screen_width == 80	; Ancho
                     00C8     6 screen_heigth == 200	 ; Alto
                     0001     7 gravity == 1
                              8 
                              9 .globl phy_update
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              8 
                              9 
                     C000    10 screen_start = 0xC000
                     0000    11 backgroun_color = 0x00
                             12 
                             13 
   412E                      14 rendersys_Wipe::
                             15     ;; Erase the las sprite position
   412E 26 C0         [ 7]   16     ld h, #0xC0
   4130 2E 00         [ 7]   17     ld l, #0x00
   4132 EB            [ 4]   18     ex de, hl
   4133 3E 00         [ 7]   19     ld  a, #backgroun_color
   4135 06 50         [ 7]   20     ld  b, #screen_width    ;;w
   4137 0E C8         [ 7]   21     ld  c, #screen_heigth    ;;H
   4139 CD 1F 44      [17]   22     call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead
                             23 
                             24 
                             25 ;;Initializes the render system by storing a pointer to the first element of the entity array
   413C                      26 rendersys_init::
   413C F5            [11]   27     push af
                             28 
   413D 11 00 C0      [10]   29     ld de, #screen_start
   4140 DD 46 01      [19]   30     ld  b, e_y(ix)    ;;y
   4143 DD 4E 00      [19]   31     ld  c, e_x(ix)    ;;x
   4146 CD CC 44      [17]   32     call cpct_getScreenPtr_asm
                             33 
   4149 DD 74 08      [19]   34     ld e_lp_h(ix), h
   414C DD 75 07      [19]   35     ld e_lp_l(ix), l
                             36 
   414F F1            [10]   37     pop af
   4150 3D            [ 4]   38     dec a
   4151 C8            [11]   39     ret z
                             40 
   4152 01 0B 00      [10]   41     ld bc, #entity_size
   4155 DD 09         [15]   42     add ix, bc
                             43 
   4157 18 E3         [12]   44     jr rendersys_init
                             45 
                             46 ;;INPUT
                             47 ;;  IX: Pointer to first entity
                             48 ;;   A: number of entities to render
   4159                      49 rendersys_update::
                             50 
   4159                      51 _renloop:
   4159 F5            [11]   52     push af
                             53 
                             54     ;; Erase the las sprite position
   415A DD 66 08      [19]   55     ld h, e_lp_h(ix)
   415D DD 6E 07      [19]   56     ld l, e_lp_l(ix)
   4160 EB            [ 4]   57     ex de, hl
   4161 3E 00         [ 7]   58     ld  a, #backgroun_color
   4163 DD 46 02      [19]   59     ld  b, e_h(ix)    ;;w
   4166 DD 4E 03      [19]   60     ld  c, e_w(ix)    ;;H
   4169 CD 1F 44      [17]   61     call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead
                             62 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             63 
                             64     ;; Draw the new sprite and store the new position
   416C 11 00 C0      [10]   65     ld de, #screen_start
   416F DD 46 01      [19]   66     ld  b, e_y(ix)    ;;y
   4172 DD 4E 00      [19]   67     ld  c, e_x(ix)    ;;x
   4175 CD CC 44      [17]   68     call cpct_getScreenPtr_asm
   4178 DD 74 08      [19]   69     ld e_lp_h(ix), h
   417B DD 75 07      [19]   70     ld e_lp_l(ix), l
   417E EB            [ 4]   71     ex de, hl
                             72     ;;ld  h, e_sprite(ix)
                             73     ;;ld  l, e_sprite_l(ix)
   417F DD 7E 06      [19]   74     ld a, e_sprite(ix)
   4182 DD 46 02      [19]   75     ld  b, e_h(ix)    ;;w
   4185 DD 4E 03      [19]   76     ld  c, e_w(ix)    ;;H
   4188 CD 1F 44      [17]   77     call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead
                             78 
                             79 
   418B F1            [10]   80     pop af
                             81 
   418C 3D            [ 4]   82     dec a
   418D C8            [11]   83     ret z
                             84 
   418E 01 0B 00      [10]   85     ld bc, #entity_size
   4191 DD 09         [15]   86     add ix, bc
   4193 18 C4         [12]   87     jr _renloop
