; general comments
;   Assignment:
;       Write a console32 Assembly Language program to calculate the perimeter of a rectangular sports court in meters.
;       Assume the largest size will be a regulation Bundesliga (German professional league) soccer field.
;       Justify the size and unsigned/signed you choose for this problem.
;       Do the problem using only registers and hard-coded data.
;       In other words, no user input.
;       Each execution will be for a fixed set of initial data.
;       You may use named memory if that makes sense to you.

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
;   https://www.bundesliga.com/en/faq/all-you-need-to-know-about-soccer/all-you-need-to-know-about-a-soccer-field-10572
;   The largest dimensions of a soccer field are 105m by 68m
;   dimensions are lengths, so they cannot be negative, so therefore, I will use all unsigned values
;   The largest perimeter possible is 105m + 105m + 68m + 68m = 346m, which goes beyond the size of a BYTE
;   as such, I must store all the data as the next size up, a WORD

.DATA
court_width     WORD  105d ; apparently, "width" is a reserved word
court_length    WORD   68d
court_perimeter WORD    0d

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main    PROC
    ; I will store intermediate values in the A register as an arbitrary choice.
    mov AX, 0d
    ; initialize the last WORD sized part of A to 0.

    add AX, court_width     ; AX = court_width
    add AX, court_width     ; AX = 2*court_width
    add AX, court_length    ; AX = 2*court_width + court_length
    add AX, court_length    ; AX = 2*court_width + 2*court_length = the perimeter

    mov court_perimeter, AX ; done with calculating, so store the value.

    mov EAX, 0
    ret
main    ENDP

END
