;;
;;Game Manager
;;

.include "game_manager.h.s"

DefineEntity player, 20, 20, 32, 4, 0, 0, 0x0F, 0xC000, 0


start_game::

   ld hl, #player
   call man_entity_create
   call man_entity_getArray
   call rendersys_init
   
   ld a, #string_Init
   call show_title_screen

   ;;Hay que mostrar por pantalla un mensaje de inicio y despues borrarlo

_wait_to_start:
    call inputsys_waitForInput
    cp #0
    jr z, _wait_to_start
    ld a, #string_Erase
    call show_title_screen
    jr game_loop


game_loop:

   call cpct_waitVSYNC_asm

   call man_entity_getArray
   call inputsys_update

   call man_entity_getArray
   call phy_update

   call man_entity_getArray
   call rendersys_update

   jr game_loop