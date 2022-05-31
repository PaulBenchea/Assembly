bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;A string of doublewords S is given. Compute string D containing only low bytes from low words from each doubleword from string S.
;S = 12345678h,1a2b3c4dh => D = 78h, 4dh
segment data use32 class=data
    ; ...	
	s dd 12345678h, 1a2b3c4dh
	;words low 5678h, 3c4dh
	;bytes low 78h, 4dh
	ls equ ($-s)/4
	d resb ls

; our code starts here
segment code use32 class=code
    start:
        ; ...
		mov esi, 0 ; s 
		mov edi, 0 ; d 
		mov ecx, ls ; set how many times to execute the instructions in repeat1
		repeat1:
			mov al, byte[s+esi] ; move in al the low byte of the low word in s
			mov [d+edi], al  ; copy the low byte of the low word to d
			add esi, 4 ; go to the next doubleword in the string
			inc edi 
		loop repeat1
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
