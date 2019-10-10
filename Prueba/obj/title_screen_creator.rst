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
                              9 .globl hide_title_screen
                             10 
                     0000    11 string_Init == 0
                     0001    12 string_Over == 1
                     0002    13 string_Erase == 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 
   404B 53 74 61 72 74 20     6 stringTitulo: .asciz "Start Game!";
        47 61 6D 65 21 00
   4057 47 61 6D 65 20 4F     7 stringOver: .asciz "Game Over!";
        76 65 72 21 00
   4062 00                    8 stringErase: .asciz "";
                              9 
                             10 
                             11 ;;INPUT
                             12 ;;A: string to be displayed
   4063                      13 show_title_screen::
                             14 
   4063 F5            [11]   15     push af
                             16     ;; Set up draw char colours before calling draw string
   4064 16 00         [ 7]   17     ld    d, #0         ;; D = Background PEN (0)
   4066 1E 03         [ 7]   18     ld    e, #3         ;; E = Foreground PEN (3)
                             19 
   4068 CD FC 44      [17]   20     call cpct_setDrawCharM1_asm   ;; Set draw char colours
                             21 
                             22     ;; Calculate a video-memory location for printing a string
   406B 11 00 C0      [10]   23     ld   de, #0xC000 ;; DE = Pointer to start of the screen
   406E 06 18         [ 7]   24     ld    b, #24                  ;; B = y coordinate (24 = 0x18)
   4070 0E 10         [ 7]   25     ld    c, #16                  ;; C = x coordinate (16 = 0x10)
                             26 
   4072 CD E0 44      [17]   27     call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                             28 
                             29     ;; Print the string in video memory
                             30     ;; HL already points to video memory, as it is the return
                             31     ;; value from cpct_getScreenPtr_asm
                             32 
                             33     ;; Change the string based on the value of a
                             34 
   4075 F1            [10]   35     pop af
   4076 FE 00         [ 7]   36     cp #string_Init
   4078 28 06         [12]   37     jr z, _intro
                             38 
   407A FE 01         [ 7]   39     cp #string_Over
   407C 28 08         [12]   40     jr z, _over
                             41 
   407E 18 0C         [12]   42     jr _erase
                             43 
   4080                      44 _intro:
   4080 FD 21 4B 40   [14]   45     ld   iy, #stringTitulo    ;; IY = Pointer to the string 
   4084 18 0A         [12]   46     jr _endif
                             47 
   4086                      48 _over:
   4086 FD 21 57 40   [14]   49     ld   iy, #stringOver    ;; IY = Pointer to the string 
   408A 18 04         [12]   50     jr _endif
                             51 
   408C                      52 _erase:
   408C FD 21 62 40   [14]   53     ld   iy, #stringErase
                             54 
   4090                      55 _endif:
                             56 
   4090 CD A2 42      [17]   57     call cpct_drawStringM1_asm  ;; Draw the string
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             58 
   4093 C9            [10]   59     ret
                             60 
   4094                      61 hide_title_screen::
                             62 
                             63     ;; Set up draw char colours before calling draw string
   4094 16 00         [ 7]   64     ld    d, #0         ;; D = Background PEN (0)
   4096 1E 00         [ 7]   65     ld    e, #0        ;; E = Foreground PEN (3)
                             66 
   4098 CD FC 44      [17]   67     call cpct_setDrawCharM1_asm   ;; Set draw char colours
                             68 
                             69     ;; Calculate a video-memory location for printing a string
   409B 11 00 C0      [10]   70     ld   de, #0xC000 ;; DE = Pointer to start of the screen
   409E 06 18         [ 7]   71     ld    b, #24                  ;; B = y coordinate (24 = 0x18)
   40A0 0E 10         [ 7]   72     ld    c, #16                  ;; C = x coordinate (16 = 0x10)
                             73 
   40A2 CD E0 44      [17]   74     call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
                             75 
   40A5 FD 21 4B 40   [14]   76     ld   iy, #stringTitulo    ;; IY = Pointer to the string 
                             77 
                             78 
   40A9 CD A2 42      [17]   79     call cpct_drawStringM1_asm  ;; Draw the string
                             80 
   40AC C9            [10]   81     ret
