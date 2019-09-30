ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;ENTITY MANAGER
                              3 ;;
                     0003     4 max_entities == 3
                     0009     5 entity_size  == 9
                              6 
   4000 00                    7 _num_entities:: .db 0 
   4001 03 40                 8 _last_elem_ptr:: .dw _entity_array
   4003                       9 _entity_array:: .ds max_entities*entity_size
                             10 
                             11 
   401E                      12 entityman_getEntityArray_IX::
   401E DD 21 03 40   [14]   13     ld  ix, #_entity_array
   4022 C9            [10]   14     ret
                             15 
   4023                      16 entityman_getNumEntities_A::
   4023 3A 00 40      [13]   17     ld  a, (_num_entities)
   4026 C9            [10]   18     ret
                             19 
                             20 ;;INPUT
                             21 ;;  HL: pointer to entity initializer bytes
   4027                      22 entityman_create::
   4027 ED 5B 01 40   [20]   23     ld de, (_last_elem_ptr)
   402B 01 09 00      [10]   24     ld bc, #entity_size
   402E ED B0         [21]   25     ldir
                             26 
   4030 3A 00 40      [13]   27     ld a, (_num_entities)
   4033 3C            [ 4]   28     inc a
   4034 32 00 40      [13]   29     ld (_num_entities), a
                             30 
   4037 2A 01 40      [16]   31     ld hl, (_last_elem_ptr)
   403A 01 09 00      [10]   32     ld bc, #entity_size
   403D 09            [11]   33     add hl, bc
   403E 22 01 40      [16]   34     ld  (_last_elem_ptr), hl
                             35 
   4041 C9            [10]   36     ret
