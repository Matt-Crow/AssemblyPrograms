; Write a console32 Assembly Language program to calculate this expression using a multiplication:
;   2 ( − a + b − 1 ) + 6
;   where
;       a is the number of semester units needed for the CRC Computer Science certificate
;       b is the population of Galt, CA as of the 2010 U.S. census
;   Rearrange the formula so you can use unsigned integers for the program.
;   Justify the sizes you choose for this problem.
;   You'll need to start small for the multiplication and then match the sizes after the multiplication.
;   Clearly describe in a Register Dictionary what every register holds as your program executes.

; general comments

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
a_units    WORD    22d ; https://crc.losrios.edu/academics/programs-and-majors/computer-information-science
b_galt_pop WORD 23647d ; https://www.census.gov/quickfacts/galtcitycalifornia
result     WORD     0d ; 2( -a + b - 1) + 6 = 47254, which fits into 16 bits

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main	PROC

	mov AX, b_galt_pop ; AX is now b
    sub AX, a_units    ; AX is now -a + b
    dec AX             ; AX is now -a + b - 1
	mov DX, 2d
    mul DX             ; DX:AX is now 2(-a + b -1)
	                   ; Only need the last WORD of DX:AX, as the result fits there.
	add AX, 6d         ; AX is now 2(-a + b - 1) + 6
	mov result, AX

	mov EAX, 0
	ret
main	ENDP

END
