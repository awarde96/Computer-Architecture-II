
includelib legacy_stdio_definitions.lib
extern printf:proc


option casemap:none				; case sensitive

.data

fxp2 db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n', 0AH, 00H

g		EQU 4
	;g:
	;dd 4
 
.code

public min

min:
	mov rax, rcx
	cmp rdx, rax
	jge else1
	mov rax, rdx
else1:
	cmp r8, rax
	jge else2
	mov rax, r8
else2:
	ret

public p

p:
	push rbx
	mov rbx, r8  ; save k in rbx	
	mov r8, rdx  ; j = j
	mov rdx, rcx ; i = i
	mov rcx, g
	sub rsp, 32	 ;allocate shadow space
	call min
	add rsp, 32  ;deallocate
			 ;get k back in rbx
	mov rcx, rax ;p0 = min(g,i,j)
	mov rdx, rbx
	mov r8, r9
	sub rsp, 32
	call min	;min((g,i,j),k,l)
	add rsp, 32
	pop rbx
	ret

public gcd

gcd:
	mov rax, rcx
	cmp rdx, 0
	je end1
	mov rcx, rdx   ;rcx = a, rdx = b
	mov rbx, rdx
	cqo
	idiv rcx
	sub rsp, 32
	mov rdx, rdx
	mov rcx, rbx
	call gcd
	add rsp, 32
end1:
	ret

public q

q:
	sub rsp, 32
	mov rax, 0
	add rax, rcx
	add rax, rdx
	add rax, r8
	add rax, r9
	add rax, [rsp+72]
	;jmp please
	
	mov [rsp+48], rax ;push sum
	mov rbx, [rsp+72]
	mov [rsp+40], rbx ;push e
	mov [rsp], r9  ;push d should be [rsp+32] but dosnt work
	mov r9, r8		  ;push c
	mov r8, rdx		  ;push b
	mov rdx, rcx	  ;push a
	lea rcx, fxp2     ;push string
	mov [rsp+64], rax
	call printf
	mov rax, [rsp+64]
;please:
	add rsp, 32
	ret




end