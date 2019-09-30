ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;RENDER SYSTEM
                              3 ;;
                              4 
                     C000     5 screen_start = 0xC000
                     0000     6 backgroun_color = 0x00
                              7 
                              8 ;;Initializes the render system by storing a pointer to the first element of the entity array
   40D7                       9 rendersys_init::
   40D7 F5            [11]   10     push af
                             11 
   40D8 11 00 C0      [10]   12     ld de, #screen_start
   40DB DD 46 01      [19]   13     ld  b, 1(ix)    ;;y
   40DE DD 4E 00      [19]   14     ld  c, 0(ix)    ;;x
   40E1 CD 72 42      [17]   15     call cpct_getScreenPtr_asm
                             16 
   40E4 DD 74 08      [19]   17     ld 8(ix), h
   40E7 DD 75 07      [19]   18     ld 7(ix), l
                             19 
   40EA 01 09 00      [10]   20     ld bc, #entity_size
   40ED DD 09         [15]   21     add ix, bc
   40EF 18 00         [12]   22     jr _renloop
                             23 
                             24 ;;INPUT
                             25 ;;  IX: Pointer to first entity
                             26 ;;   A: number of entities to render
   40F1                      27 rendersys_update::
                             28 
   40F1                      29 _renloop:
   40F1 F5            [11]   30     push af
                             31 
                             32     ;; Erase the las sprite position
   40F2 DD 66 08      [19]   33     ld h, 8(ix)
   40F5 DD 6E 07      [19]   34     ld l, 7(ix)
   40F8 EB            [ 4]   35     ex de, hl
   40F9 3E 00         [ 7]   36     ld  a, #backgroun_color
   40FB DD 46 03      [19]   37     ld  b, 3(ix)    ;;w
   40FE DD 4E 02      [19]   38     ld  c, 2(ix)    ;;H
   4101 CD C5 41      [17]   39     call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead
                             40 
                             41 
                             42     ;; Draw the new sprite and store the new position
   4104 11 00 C0      [10]   43     ld de, #screen_start
   4107 DD 46 01      [19]   44     ld  b, 1(ix)    ;;y
   410A DD 4E 00      [19]   45     ld  c, 0(ix)    ;;x
   410D CD 72 42      [17]   46     call cpct_getScreenPtr_asm
   4110 DD 74 08      [19]   47     ld 8(ix), h
   4113 DD 75 07      [19]   48     ld 7(ix), l
   4116 EB            [ 4]   49     ex de, hl
   4117 DD 7E 06      [19]   50     ld  a, 6(ix)
   411A DD 46 03      [19]   51     ld  b, 3(ix)    ;;w
   411D DD 4E 02      [19]   52     ld  c, 2(ix)    ;;H
   4120 CD C5 41      [17]   53     call cpct_drawSolidBox_asm ;;For this first iteration Entities will not have strites and will be solid boxes instead
                             54 
   4123 F1            [10]   55     pop af
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 
   4124 3D            [ 4]   57     dec a
   4125 C8            [11]   58     ret z
                             59 
   4126 01 09 00      [10]   60     ld bc, #entity_size
   4129 DD 09         [15]   61     add ix, bc
   412B 18 C4         [12]   62     jr _renloop
