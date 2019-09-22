ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
   4064                       5 rendersys_init::
                              6 
                              7 ;;INPUT
                              8 ;;  IX: Pointer to first entity
                              9 ;;   A: number of entities to render
   4064                      10 rendersys_update::
                             11 
   4064                      12 _renloop:
   4064 F5            [11]   13     push af
                             14 
   4065 11 00 C0      [10]   15     ld de, #0xC000
   4068 DD 46 01      [19]   16     ld  b, 1(ix)    ;;y
   406B DD 4E 00      [19]   17     ld  c, 0(ix)    ;;x
   406E CD 44 41      [17]   18     call cpct_getScreenPtr_asm
                             19 
   4071 EB            [ 4]   20     ex de, hl
   4072 DD 7E 06      [19]   21     ld  a, 6(ix)
   4075 DD 46 03      [19]   22     ld  b, 3(ix)    ;;w
   4078 DD 4E 02      [19]   23     ld  c, 2(ix)    ;;H
   407B CD 98 40      [17]   24     call cpct_drawSolidBox_asm
                             25 
   407E F1            [10]   26     pop af
                             27 
   407F 3D            [ 4]   28     dec a
   4080 C8            [11]   29     ret z
                             30 
   4081 01 07 00      [10]   31     ld bc, #entity_size
   4084 DD 09         [15]   32     add ix, bc
   4086 18 DC         [12]   33     jr _renloop
