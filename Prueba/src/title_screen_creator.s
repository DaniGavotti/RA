;;
;;Title Screen creator
;;
.include "title_screen_creator.h.s"

stringTitulo: .asciz "Start Game!";
stringOver: .asciz "Game Over!";
stringErase: .asciz "";


;;INPUT
;;A: string to be displayed
show_title_screen::

    push af
    ;; Set up draw char colours before calling draw string
    ld    d, #0         ;; D = Background PEN (0)
    ld    e, #3         ;; E = Foreground PEN (3)

    call cpct_setDrawCharM1_asm   ;; Set draw char colours

    ;; Calculate a video-memory location for printing a string
    ld   de, #0xC000 ;; DE = Pointer to start of the screen
    ld    b, #24                  ;; B = y coordinate (24 = 0x18)
    ld    c, #16                  ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ;; Print the string in video memory
    ;; HL already points to video memory, as it is the return
    ;; value from cpct_getScreenPtr_asm

    ;; Change the string based on the value of a

    pop af
    cp #string_Init
    jr z, _intro

    cp #string_Over
    jr z, _over

    jr _erase

_intro:
    ld   iy, #stringTitulo    ;; IY = Pointer to the string 
    jr _endif

_over:
    ld   iy, #stringOver    ;; IY = Pointer to the string 
    jr _endif

_erase:
    ld   iy, #stringErase

_endif:

    call cpct_drawStringM1_asm  ;; Draw the string

    ret

hide_title_screen::

    ;; Set up draw char colours before calling draw string
    ld    d, #0         ;; D = Background PEN (0)
    ld    e, #0        ;; E = Foreground PEN (3)

    call cpct_setDrawCharM1_asm   ;; Set draw char colours

    ;; Calculate a video-memory location for printing a string
    ld   de, #0xC000 ;; DE = Pointer to start of the screen
    ld    b, #24                  ;; B = y coordinate (24 = 0x18)
    ld    c, #16                  ;; C = x coordinate (16 = 0x10)

    call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

    ld   iy, #stringTitulo    ;; IY = Pointer to the string 


    call cpct_drawStringM1_asm  ;; Draw the string

    ret
