%include "asm_io.inc"
segment .data 
	A:	db 'A= ', 0
	B:	db 'B= ', 0
	C:	db 'C= ', 0
	D:	db 'D= ', 0
	Mod1:	db 'A mod C is ', 0
	Mod2:	db 'C mod B is ', 0
	Result:	db 'The result is ', 0 
segment .bss 
;	thata:	db
;	thatb:	db
;	thatc:	db
;	thatd:	db
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	;***************CODE STARTS HERE***************************
	call read_int
	mov ebx, eax
	mov eax, A
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	call read_int
	mov ecx, eax
	mov eax, B
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	call read_int
	mov esi, eax
	mov eax, C
	call print_string
	mov eax, esi
	call print_int
	call print_nl
	mov eax, D
	call print_string
	call read_int
	call print_int
	mov edi, eax
	call print_nl
	mov eax, Mod1
	call print_string
	mov eax, ebx
	mov edx, 0
	div esi
	mov eax, edx
	call print_int
	call print_nl
	mov ebx, eax
	mov eax, Mod2
	call print_string
	mov eax, esi
	mov edx, 0
	div ecx
	mov eax, edx
	call print_int
	call print_nl
	mov esi, eax
	mov eax, Result
	call print_string
	mov eax, ecx
	mul ecx
	mul ecx
	mul ebx
	mov edx, 0
	div esi
	add eax, edi
	call print_int
	call print_nl
;	call read_int
;	mov eax, 7
;	mov ebx, eax
;	mov eax, 11
;	mov 
;	call print_int
;	call print_string
	;***************CODE ENDS HERE*****************************
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret
