bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf        ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
; our data is declared here (the variables needed by our program)
;Read two numbers a and b in decimal.
;Calculate their product and display the result in the following format: "<a> / <b> = <result>". 
;Example: "4 / 2 = 1" The value of result will be displayed in hexadecimal format.
segment data use32 class=data
    ; ...
	a dd 0 
	b dd 0 
	formatdecimal db '%d', 0
	formathexadecimal db '%x', 0
	printmesajinceputa db 'Insert a in decimal: ', 0
	printmesajinceputb db 'Insert b in decimal: ', 0
	printresult db '%d / %d = %x', 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
		; print on the screen: Insert a in decimal:
		push dword printmesajinceputa
		call [printf]
		add esp, 4*1 ; we clear the stack
		;read a
		push dword a
		push dword formatdecimal
		call [scanf]
		add esp, 4*2
		; print on the screen: Insert b in decimal:
		push dword printmesajinceputb
		call [printf]
		add esp, 4*1 ; we clear the stack
		;read b
		push dword b
		push dword formatdecimal
		call [scanf]
		add esp, 4*2
		
		mov eax, [a]
		mov ebx, [a]
		mov ecx, [b]
		cdq ; we move a in edx:eax
		idiv ecx ; a/b 
		
		; print on the screen: %d/%d = %x
		push eax ; push a/b in %x
		push ecx ; push b in %d
		push ebx ; push a in %d
		push dword printresult 
		call [printf]
		
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
