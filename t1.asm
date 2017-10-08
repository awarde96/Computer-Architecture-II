.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

 .data

public g
g dword 4

.code

public min

min:	push ebp
		mov ebp, esp
		sub esp, 4	

		mov eax, [ebp+8] 
		mov [ebp-4], eax 
		mov eax, [ebp+12] 
		cmp eax, [ebp-4]  
		jge min1
		mov eax, [ebp+12]		
		mov [ebp-4], eax
min1:
		mov eax, [ebp+16] 	 
		cmp eax, [ebp-4]	 
		jge min2
		mov eax, [ebp+16]    
		mov [ebp-4], eax
min2:
		mov eax, [ebp-4]
		mov esp, ebp
		pop ebp
		ret

public p

p:	push ebp
	mov ebp, esp
	sub esp, 4

	mov eax, [ebp+12]
	push eax		
	mov eax, [ebp+8]
	push eax		
	mov eax, [g]	
	push eax 		
	call min	
	add esp, 12
	mov [ebp-4], eax
	mov eax, [ebp-4]

	mov esp, ebp
	pop ebp
	ret

public gcd

gcd:	push ebp
		mov ebp, esp
		sub esp, 4

		mov eax, [ebp+12]
		mov ebx, 0
		cmp eax, ebx
		je end1
				
		mov eax, [ebp+8]
		mov ecx, [ebp+12]
		mov edx, 0
		cdq
		idiv ecx
		mov eax, edx
		push eax
		mov eax, [ebp+12]
		push eax
		call gcd
		add esp, 8
		jmp end2

end1:	
		mov eax, [ebp+8]
end2:
		mov esp, ebp
		pop ebp
		ret


end
