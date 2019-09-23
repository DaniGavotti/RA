ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
   4090                       5 rendersys_init::
                              6 
                              7 ;;INPUT
                              8 ;;  IX: Pointer to first entity
                              9 ;;   A: number of entities to render
   4090                      10 rendersys_update::
                             11 
   4090                      12 _renloop:
   4090 F5            [11]   13     push af
                             14 
   4091 11 00 C0      [10]   15     ld de, #0xC000
   4094 DD 46 01      [19]   16     ld  b, 1(ix)    ;;y
   4097 DD 4E 00      [19]   17     ld  c, 0(ix)    ;;x
   409A CD 79 41      [17]   18     call cpct_getScreenPtr_asm
                             19 
   409D EB            [ 4]   20     ex de, hl
   409E DD 7E 06      [19]   21     ld  a, 6(ix)
   40A1 DD 46 03      [19]   22     ld  b, 3(ix)    ;;w
   40A4 DD 4E 02      [19]   23     ld  c, 2(ix)    ;;H
   40A7 CD CC 40      [17]   24     call cpct_drawSolidBox_asm
                             25 
   40AA F1            [10]   26     pop af
                             27 
   40AB 3D            [ 4]   28     dec a
   40AC C8            [11]   29     ret z
                             30 
   40AD 01 07 00      [10]   31     ld bc, #entity_size
   40B0 DD 09         [15]   32     add ix, bc
   40B2 18 DC         [12]   33     jr _renloop
