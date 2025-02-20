; general comments
; if((ch >= 'a') && (ch <= 'z')){
;   lowerCount++;
; } else {
;   if((ch >= 'A') && (ch <= 'Z')){
;       upperCount++;
;   } else {
;       otherCount++;
;   }
; }
;
; ch is AL
; lowerCount, upperCount, and otherCount are all bytes in named memory
; everything is unsigned

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
lowerCount BYTE 0d
upperCount BYTE 0d
otherCount BYTE 0d

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main	PROC

	mov AL, 'm'

    checkLowerCaseLower:
        cmp AL, 'z'
        ja checkUpperCaseLower ; must be at most 'z' to be lower case. Breaks out of && if it isn't
    checkLowerCaseUpper:
        cmp AL, 'a'
        jb checkUpperCaseLower ; jumps if it fails the first if block
    isLowerCase: ; if it passed both of the above, it's lower case
		mov BL, lowerCount
		inc BL
		mov lowerCount, BL ; not allowed to use inc on a non-register
        jmp done

    ; check for upper case
    checkUpperCaseLower:
        cmp AL, 'Z'
        ja neitherUpperNorLower
    checkUpperCaseUpper:
        cmp AL, 'A'
        jb neitherUpperNorLower
    isUpperCase:
		mov BL, upperCount
        inc BL
		mov upperCount, BL
        jmp done

    neitherUpperNorLower:
		mov BL, otherCount
        inc BL
		mov otherCount, BL
        jmp done

    done:
        ; done

	mov EAX, 0
	ret
main	ENDP

END
