
.include "game_manager.h.s"

.area _DATA
.area _CODE

.globl cpct_disableFirmware_asm


_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm
   call start_game

