; Assignment:
; Use the template console32 package to complete this lab.
; Write a complete assembly language program to compute the expression
; 2(−a + b − 1) + c
; where
;   a is the area code of your phone number
;   b is the first three digits of your phone number
;   c is the last four digits of your phone number
; Create a Google Doc, saved as a PDF, that contains the following information:
;   1. a discussion of your choice of size for this problem. Include all the intermediate calculated values and justify your choice. You must choose the smallest register size possible.
;   2. A discussion of signed or unsigned integers for this problem.  Justify your choice with data.
;   3. An image of your main.asm file. Include in the comments the data that is held in each of the registers that you use in the problem (a Register Dictionary).
;   4. Multiple screen shots of a line-by-line execution of the program. After each calculation show the result as hexadecimal and decimal, and the EFLAGS bit showing the result of the calculation is mathematically correct.
; Name your PDF whatever you like. Upload it before the due date and time.



; general comments
; Register Dictionary
;     AX holds the result as it's being calculated
;     BX holds temporary values

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
phone_a   WORD     916d ; area code of phone number
phone_b   WORD     205d ; first 3 digits of phone number
phone_c   WORD    0465d ; last 4 digits of phone number
result    WORD       0d ; this will store the result of 2(-phone_a + phone_b - 1) + phone_c
; All of these should be interpreted as being signed

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main	PROC
	mov AX, phone_b ; AX is now phone_b
	mov BX, phone_a
	sub AX, BX      ; AX is now -phone_a + phone_b
	dec AX          ; AX is now -phone_a + phone_b - 1
	add AX, AX      ; AX is now 2(-phone_a + phone_b - 1)
	mov BX, phone_c
	add AX, BX      ; AX is now 2(-phone_a + phone_b - 1) + phone_c
	mov result, AX  ; result is now 2(-phone_a + phone_b - 1) + phone_c

	mov EAX, 0
	ret
main	ENDP
END
