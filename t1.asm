g: dword 4 // int g = 4

// int min (int a, int b, int c)

push 3		//push immediate values
push 2
push 1
call min
add esp, 12



//function body of min
min:	push ebp
		mov ebp, esp
		sub esp, 4	//allocate space for one local v

		mov eax, [ebp+8] // eax = a
		mov [ebp-4], eax // v = a
		mov eax, [ebp+12] // eax = b
		cmp eax, [ebp-4]  // if (b < v)
		jge min1
		mov eax, [ebp+12]		// v = b
		mov [ebp-4], eax
min1:
		mov eax, [ebp+16] 	 // eax = c
		cmp eax, [ebp-4]	 // if(c < v)
		jge min2
		mov eax, [ebp+16]     //v = c
		mov [ebp-4], eax
min2:
		mov eax, [ebp-4]
		mov esp, ebp
		pop ebp
		ret



//function body of pop
p:	push ebp
	mov ebp, esp
	sub esp, 4

	mov eax, [ebp+12]
	push eax		//push j
	mov eax, [ebp+8]
	push eax		//push i
	mov eax, [g]	//int g
	push eax 		//push g
	call min		// min(g,i,j)
	add esp, 12
	mov [ebp-4], eax
	mov eax, [ebp-4]

	mov esp, ebp
	pop ebp
	ret


//function of body gcd
gcd:	push ebp
		mov ebp, esp

		mov eax, [ebp+12] // eax = b
		cmp eax, 0		  // b == 0
		jne else
		mov eax, [ebp+8]  //return a
		mov esp, ebp
		pop ebp
		ret

else:	mov eax, [ebp+12]
		push eax	//push b
		mov ecx, eax // ecx = b
		idiv ecx
		mov eax, edx  // a mod b
		push eax
		call gcd	//gcd(b, a mod b)
		add esp, 8

		mov esp, ebp
		pop ebp
		ret

//max depth of stack is 2 in stack frames
