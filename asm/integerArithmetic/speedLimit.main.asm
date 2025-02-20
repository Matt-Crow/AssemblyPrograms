; general comments
; Register Dictionary:
;    AH will hold speedMax (x)
;    AL will hold speedMin (y). Later, it will hold the quotient
;    AX will hold the numerator
;    BL will hold the denominator

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
speedMin BYTE 30d
speedMax BYTE 50d
speedAvg BYTE  0d

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main	PROC
    ; could do this one of two ways:
    ;     1. by using addition like this
    ;     2. by chaining multiplication (see chainDivide.main.asm)
    mov AH, speedMax
    mov AL, speedMin
    mul AH           ; AX is now xy
    add AX, AX       ; AX is now 2xy
    mov BL, speedMax
    add BL, speedMin ; BL is now x + y
    div BL           ; (AH:AL) / BL
    mov speedAvg, AL
    mov EAX, 0
    ret
main	ENDP

END
