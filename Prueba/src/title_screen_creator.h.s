;;
;;Title Screen Creator H
;;

.globl cpct_getScreenPtr_asm
.globl cpct_setDrawCharM1_asm
.globl cpct_drawStringM1_asm
.globl show_title_screen
.globl hide_title_screen

string_Init == 0
string_Over == 1
string_Erase == 2