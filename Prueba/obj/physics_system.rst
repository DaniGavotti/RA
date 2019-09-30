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
   4042                       9 phy_update::
                             10 
   4042                      11 _phyloop:
   4042 F5            [11]   12     push af
                             13 
                             14     ;;Updates y
   4043 DD 7E 01      [19]   15     ld  a, 1(ix)    ;;y
   4046 DD 86 05      [19]   16     add 5(ix)
   4049 DD 77 01      [19]   17     ld  1(ix), a
                             18 
                             19     ;;Updates x
   404C DD 7E 00      [19]   20     ld  a, 0(ix)    ;;x
   404F DD 86 04      [19]   21     add 4(ix)
   4052 DD 77 00      [19]   22     ld  0(ix), a
                             23 
   4055 F1            [10]   24     pop af
                             25 
   4056 3D            [ 4]   26     dec a
   4057 C8            [11]   27     ret z
                             28 
   4058 01 09 00      [10]   29     ld bc, #entity_size
   405B DD 09         [15]   30     add ix, bc
   405D 18 E3         [12]   31     jr _phyloop
