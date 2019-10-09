ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;
                              2 ;;Physics.h.s
                              3 ;;
                              4 
                     0050     5 screen_width == 80	; Ancho
                     00C8     6 screen_heigth == 200	 ; Alto
                     0001     7 gravity == 1
                              8 
                              9 .globl phy_update
