ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;PHYSICS SYSTEM
                              3 ;;
                              4 
                              5 ;; Updates the position of entities by adding their speed to their position
                              6 ;;  IX: Pointer to first entity
                              7 ;;   A: number of entities to update
                              8 
   403C                       9 phy_update::
                             10 
   403C                      11 _phyloop:
   403C F5            [11]   12     push af
                             13 
   403D 11 00 C0      [10]   14     ld de, #0xC000
   4040 DD 7E 01      [19]   15     ld  a, 1(ix)    ;;y
   4043 DD 86 05      [19]   16     add 5(ix)
   4046 DD 77 01      [19]   17     ld  1(ix), a
                             18 
   4049 DD 7E 00      [19]   19     ld  a, 0(ix)    ;;x
   404C DD 86 04      [19]   20     add 4(ix)
   404F DD 77 00      [19]   21     ld  0(ix), a
                             22 
   4052 F1            [10]   23     pop af
                             24 
   4053 3D            [ 4]   25     dec a
   4054 C8            [11]   26     ret z
                             27 
   4055 01 07 00      [10]   28     ld bc, #entity_size
   4058 DD 09         [15]   29     add ix, bc
   405A 18 E0         [12]   30     jr _phyloop
