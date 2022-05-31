bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;A string of bytes A is given. 
; Construct string B such that each element from B represent the product of 
; two consecutive elements from string A.If A = 2,4, 5, 7=> B = 8, 20, 35
segment data use32 class=data
    ; ...
	a db 2, 4, 5, 7
	la equ $-a
	b times la-1 dw -1
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		mov esi, 0 ;a 
		mov edi, 0 ;b
		mov ecx, la-1 ; set how many times to execute the instructions in repeat1
		repeat1:
			mov al, [a+esi] ; move in al the first element
			mov bl, [a+esi+1] ; move in al the next element
			mul bl ; multiply the first element with the next one
			mov [b+edi], ax ; move in b the result
			inc esi ; increase index a 
			inc edi			; increase index b
			inc edi
		loop repeat1
		;result b: 8, 14h, 23h <=> 8, 20, 35
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
