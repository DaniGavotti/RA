ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Title Screen creator
                              3 ;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "title_screen_creator.h.s"
                              1 ;;
                              2 ;;Title Screen Creator H
                              3 ;;
                              4 
                              5 .globl cpct_getScreenPtr_asm
                              6 .globl cpct_setDrawCharM1_asm
                              7 .globl cpct_drawStringM1_asm
                              8 .globl show_title_screen
                              9 
                     0000    10 string_Init == 0
                     0001    11 string_Over == 1
                     0002    12 string_Erase == 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 
   404E 53 74 61 72 74 20     6 stringTitulo: .asciz "Start Game!";
        47 61 6D 65 21 00
   405A 47 61 6D 65 20 4F     7 stringOver: .asciz "Game Over!";
        76 65 72 21 00
   4065 00                    8 stringErase: .asciz "";
                              9 
                             10 
                             11 ;;INPUT
                             12 ;;A: string to be displayed
   4066                      13 show_title_screen::
                             14 
   4066 F5            [11]   15     push af
                             16     ;; Set up draw char colours before calling draw string
   4067 16 00         [ 7]   17     ld    d, #0         ;; D = Background PEN (0)
   4069 1E 03         [ 7]   18     ld    e, #3         ;; E = Foreground PEN (3)
                             19 
   406B CD E8 44      [17]   20     call cpct_setDrawCharM1_asm   ;; Set draw char colours
                             21 
                             22     ;; Calculate a video-memory location for printing a string
   406E 11 00 C0      [10]   23     ld   de, #0xC000 ;; DE = Pointer to start of the screen
   4071 06 18         [ 7]   24     ld    b, #24                  ;; B = y coordinate (24 = 0x18)
   4073 0E 10         [ 7]   25     ld    c, #16                  ;; C = x coordinate (16 = 0x10)
                             26 
   4075 CD CC 44      [17]   27     call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                             28 
                             29     ;; Print the string in video memory
                             30     ;; HL already points to video memory, as it is the return
                             31     ;; value from cpct_getScreenPtr_asm
                             32 
                             33     ;; Change the string based on the value of a
                             34 
   4078 F1            [10]   35     pop af
   4079 FE 00         [ 7]   36     cp #string_Init
   407B 28 06         [12]   37     jr z, _intro
                             38 
   407D FE 01         [ 7]   39     cp #string_Over
   407F 28 08         [12]   40     jr z, _over
                             41 
   4081 18 0C         [12]   42     jr _erase
                             43 
   4083                      44 _intro:
   4083 FD 21 4E 40   [14]   45     ld   iy, #stringTitulo    ;; IY = Pointer to the string 
   4087 18 0A         [12]   46     jr _endif
                             47 
   4089                      48 _over:
   4089 FD 21 5A 40   [14]   49     ld   iy, #stringOver    ;; IY = Pointer to the string 
   408D 18 04         [12]   50     jr _endif
                             51 
   408F                      52 _erase:
   408F FD 21 65 40   [14]   53     ld   iy, #stringErase
                             54 
   4093                      55 _endif:
                             56 
   4093 CD 8E 42      [17]   57     call cpct_drawStringM1_asm  ;; Draw the string
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             58 
   4096 C9            [10]   59     ret
