;;
;;Input System
;;

.include "cpctelera.h.s"
.include "cpct_functions.h.s"

;;System that will read the keys the user is presing and modify the player's character attributes acordingly

inputsys_init::
    ret

inputsys_update::
    ;;reset velocity
    ld 4(ix), #0 ;;x_speed
    ld 5(ix), #0 ;;y_speed

    ;;Scan Keys
    call cpct_scanKeyBoar_f_asm

    ;;If O pressed
    ld hl, #Key_O
    call cpct_isKeyPressed_asm
    jr nz, _notPressed_O
_pressed_O:
    ld 4(ix), #-1
_notPressed_O:

    ;;If P pressed
    ld hl, #Key_P
    call cpct_isKeyPressed_asm
    jr nz, _notPressed_P
_pressed_P:
    ld 4(ix), #1
_notPressed_P:

    ;;If Q pressed
    ld hl, #Key_Q
    call cpct_isKeyPressed_asm
    jr nz, _notPressed_Q
_pressed_Q:
    ld 5(ix), #-1
_notPressed_Q:

    ;;If A pressed
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    jr nz, _notPressed_A
_pressed_A:
    ld 5(ix), #1
_notPressed_A:

