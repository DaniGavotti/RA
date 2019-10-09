.include "cpctelera.h.s"
.include "entity_manager.h.s"
.include "render_system.h.s"
.include "physics_system.h.s"
.include "input_system.h.s"


.area _DATA
.area _CODE

.globl cpct_disableFirmware_asm
.globl cpct_waitVSYNC_asm

DefineEntity player, 20, 20, 32, 4, 0, 0, 0x0F, 0xC000, 0

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ld hl, #player
   call man_entity_create

   ;;ld hl, #enemy
   ;;call entityman_create

loop:

   call cpct_waitVSYNC_asm

   call man_entity_getArray
   call inputsys_update

   call man_entity_getArray
   call phy_update

   call man_entity_getArray
   call rendersys_update

   jr loop

