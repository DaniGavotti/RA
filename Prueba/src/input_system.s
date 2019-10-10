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


;;lee el teclado y espera a que se presione cualquier tecla para devolver 1 en cualquer otro caso devuelve 0
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

    ;;Check if character state is diferent from standing

    ld a, e_state(ix)
    ;;If character state is jumping
    cp #jumping
    jr z, _endInput

    ;;If charcter state is crouched
    cp #crouched
    jr nz, _begin
    jr _crouched_player

_begin:
    ;;reset velocity and state
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

    ;;If Q pressed(Jump)
    ld hl, #Key_Q
    call cpct_isKeyPressed_asm
    jr z, _notPressed_Q
_pressed_Q:
    ld e_state(ix), #jumping
    ld e_vy(ix), #-15
_notPressed_Q:


    ;;If A pressed(Crouched)
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    jr z, _notPressed_A
_pressed_A:
    ;;if a is pressed the player will crouch
    ld a, e_y(ix)
    add #15
    ld e_y(ix), a
    ld e_h(ix), #16
    ld e_state(ix), #crouched
    ld e_vy(ix), #4
_notPressed_A:
    jr _endInput

_crouched_player:
    ;;If A pressed(Crouched)
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    jr z, _reset_state
    jr _endInput
_reset_state:
    ;;If state crouched and A is no pressed reset player size
    ld a, e_y(ix)
    sub #17
    ld e_y(ix), a
    ld e_h(ix), #32
    ld e_state(ix), #standing

_endInput:

    ret

