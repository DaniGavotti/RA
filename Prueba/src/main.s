.include "cpctelera.h.s"


.area _DATA
.area _CODE

player: .db 20, 20, 2, 8, 1, 1, 0x0F, 0xC000
enemy: .db 40, 40, 4, 8, -1, 2, 0xFF, 0xC000

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ld hl, #player
   call entityman_create

   ld hl, #enemy
   call entityman_create

loop:

   call cpct_waitVSYNC_asm

   call entityman_getEntityArray_IX
   call inputsys_update

   call entityman_getEntityArray_IX
   call entityman_getNumEntities_A
   call phy_update

   call entityman_getEntityArray_IX
   call entityman_getNumEntities_A
   call rendersys_update

   jr loop

