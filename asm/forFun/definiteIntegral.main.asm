; general comments
;   This is a program I made for myself to practice just about everything I've learned in CISP 310 up to this point.
;   This program computes the integral from a to b of f(x) dx using Riemann Sum estimation using the formula
;
;   I = the sum from i = 1 to n of f(a + i*dx)*dx
;   where dx = (b - a) / n

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
_a     REAL4   2.5  ; Lower limit of integration
_b     REAL4   3.25 ; Upper limit of integration
_n     DWORD 1000d  ; Number of rectangles to estimate using
deltaX REAL4   0.0  ; computed by program
sigma  REAL4   0.0  ; computed by program
_i     DWORD   1d   ; current rectangle number, set by program
four   REAL4   4.0  ; used for f(x)

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main PROC
	; Step 1: compute deltaX
	; Instruction | ST(0)  |  ST(1) | comments
	finit         ; ~~~       ~~~     Prepare floating point registers
    fld _b        ; b         ~~~     Push upper limit of integration
	fld _a        ; a         b       Push lower limit of integration
    fsub          ; b-a       ~~~     Compute width of limits of integration
    fild _n       ; n         b-a     Push the number of rectangles
    fdiv          ; (b-a)/n   ~~~     Compute dx
    fstp deltaX   ; ~~~       ~~~     Store dx

	; Step 2: compute sigma
	mov ECX, 1d ; will store _i in ECX so I can increment it
	checkSigmaRange: ; FOR i from 1 to n (inclusive of end points)
        cmp ECX, _n
        jbe addNextTerm
        jmp doneLooping
    addNextTerm:
        ; Instruction | ST(0)  | ST(1) | comments
		finit         ; ~~~      ~~~     Need to initialize float registers before each iteration
        fld deltaX    ; dx       ~~~     Push width of rectangle
        fild _i       ; i        dx      Push rectangle number
        fmul          ; i*dx     ~~~     Compute current x offset
		fld _a        ; a        i*dx    Push starting x
		fadd          ; a+i*dx   ~~~     Compute current x
		; ### Compute the function value
		; 	While I would like to move f(x) to its own procedure,
		;   I don't know how to do floating point procedures yet
		;	You can change these lines if you want to integrate a different function
		fld ST(0)     ; a+i*dx   a+i*dx  Duplicate current x
		fmul          ; x^2      ~~~     Compute x^2
		fld four      ; 4        x^2
		fmul          ; 4(x^2)   ~~~
		fldpi         ; PI       4(x^2)
		fmul          ; 4PIx^2   ~~~     ST(0) now contains the rectangle's height
		; ### End computing function value
		fld deltaX    ; dx       h       Push rectangle width
		fmul          ; h*dx     ~~~     Compute rectangle area
		fld sigma     ; sigma    h*dx    Push current sum
        fadd          ; new sum  ~~~     Add current rectangle's area to the sum
		fstp sigma    ; ~~~      ~~~     Update saved sum
        inc ECX                          ; Move to the next term
		mov _i, ECX
        jmp checkSigmaRange
    doneLooping:
        ; The integral is now stored in sigma

	; Note how I am multiplying by dx inside the loop, rather than after summing all the rectangles
	; This is to prevent sigma from going beyond the limits of floating point numbers when values get large
	; dx is really small, so that counteracts large heights

	mov EAX, 0
	ret
main ENDP

END
