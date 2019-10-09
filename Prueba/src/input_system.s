;;
;;Input System
;;

.include "cpctelera.h.s"
.include "entity_manager.h.s"
;;System that will read the keys the user is presing and modify the player's character attributes acordingly

.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
.globl cpct_isAnyKeyPressed_f_asm

inputsys_init::
    ret

inputsys_waitForInput::
    ;;Scan Keys
    call cpct_scanKeyboard_f_asm

    ;;If any key pressed
    call cpct_isAnyKeyPressed_f_asm
    ld a, #0
    jr z, _notPressed
_pressed:
    ld a, #1
    ;;Devuelve algo enun registro
_notPressed:
    ret


inputsys_update::
    ;;reset velocity
    ld e_vx(ix), #0 ;;x_speed
    ;;ld e_vy(ix), #0 ;;y_speed

    ;;Scan Keys
    call cpct_scanKeyboard_f_asm

    ;;If O pressed
    ld hl, #Key_O
    call cpct_isKeyPressed_asm
    jr z, _notPressed_O
_pressed_O:
    ld e_vx(ix), #-1
_notPressed_O:

    ;;If P pressed
    ld hl, #Key_P
    call cpct_isKeyPressed_asm
    jr z, _notPressed_P
_pressed_P:
    ld e_vx(ix), #1
_notPressed_P:

    ;;If Q pressed
    ld hl, #Key_Q
    call cpct_isKeyPressed_asm
    jr z, _notPressed_Q
_pressed_Q:
    ld e_vy(ix), #-8
_notPressed_Q:

    ;;If A pressed
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    jr z, _notPressed_A
_pressed_A:
    ld e_vy(ix), #4
_notPressed_A:

    ret

