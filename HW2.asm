%include "asm_io.inc"
segment .data 
	UnitSizePrompt:	db 'Enter the unit for file size:', 0
	NetworkPrompt:	db 'Enter the unit for throughput:', 0
	SizePrompt:	db 'Enter the file size:', 0
	SpeedPrompt:	db 'Enter the throughput:', 0
	TimePrompt:	db 'The time would be ', 0
	Seconds:	db ' seconds.', 0
	Test:	db 'Blarg', 0
segment .bss 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
	;***************CODE STARTS HERE***************************
	;Get File Size Unit
	mov eax, UnitSizePrompt
	call print_string
	call read_char
	push eax
;	mov ebx, eax

	;Get Unit of Network Connection
	mov eax, NetworkPrompt
	call print_string
	call read_char
	call read_char
	push eax
;	mov ecx, eax

	;Get File size
	mov eax, SizePrompt
	call print_string
	call read_int
	push eax
;	mov edx, eax

	;Get throughPut
	mov eax, SpeedPrompt
	call print_string
	call read_int
	push eax

	;start time prompt
	mov eax, TimePrompt
	call print_string

	;start conversion function
	call conversion

	;print out return and end of time prompt
	call print_int
	mov eax, Seconds
	call print_string
	call print_nl

	;remove inserted parameters
	add esp, 16
	
		
	;***************CODE ENDS HERE*****************************
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

;conversion function
conversion:
	push ebp
	mov ebp, esp
	pushad

	sub esp, 8 ;make room for local variable

	;convert File Size unit to bits
	mov ebx, [ebp +20]

	mov eax, 'M' ;check for Megabytes
	cmp eax, ebx
	jz size_megabytes
	
	mov eax, 'K' ;check for Kilobytes
	cmp eax, ebx
	jz size_kilobytes
	
	mov eax, [ebp +12];set eax to the bytes
	jmp endif

size_megabytes:
	;shift 2^20 for megabytes to bytes
	mov eax, [ebp + 12]
	shl eax, 20
	jmp endif

size_kilobytes:
	;shit 2^10 for kilobytes to bytes
	mov eax, [ebp + 12]
	shl eax, 10

endif:
	shl eax, 3;shift bytes to bits
	mov [esp+8], eax ;store bits in local variable
	
	;shift to correct bit form
	mov ebx, [ebp + 16]

	mov eax, 'M'; throughput Megabits
	cmp eax, ebx
	jz through_m
	
	mov eax, 'K' ; throughput kilobits
	cmp eax, ebx
	jz through_k

	mov eax, [esp+8]; set eax to the filesize in bits
	jmp endif

through_m:
	mov eax, [esp + 8]
	shr eax, 20 ;shift bits to Mega bits 2^20
	jmp end_through

through_k:
	mov eax, [esp+8]
	shr eax, 10 ; shift bits to kilo bits 2^10

end_through:
	mov ebx, [ebp + 8]; set ebx to the throughput value
	mov edx, 0
	div ebx
	
	
	add esp, 8 ;remove local variable
	
;return values to functions
	pop edi
	pop esi
	pop ebp
	pop esp
	pop ebx
	pop edx
	pop ecx
	add esp, 4
	
	;epilogue
	mov esp, ebp
	pop ebp
	ret

;Millers's stuff:
;Prologue
	;push ebp
	;mov ebp, esp
;Epilogue:
	;mov esp ebp
;	pop ebp
	;ret

;mov edx, [ebpt+8]
