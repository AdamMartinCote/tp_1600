.data
	n:	.long 11

.global func_s

func_s:	
	mov $0, %ecx
for:
	/* a = a + e - b; */
	mov a, %eax
	add e, %eax
	sub b, %eax
	mov %eax, a;
	
	/* if (i <= e + 1) */
	mov e, %eax
	add $1, %eax
	cmp %eax, %ecx
	jna do
	
	/* if (b == c + 2) */
	mov c, %eax
	add $10, %eax
	cmp b, %eax
	je do
	
	jmp else
	
	do:
		
		/* a = c + a - e */
		mov a, %eax
		add c, %eax
		sub e, %eax
		mov %eax, a
		
		/* b = b + 2 */
		mov b, %eax
		add $2, %eax
		mov %eax, b		

		jmp endif
		
	else:
		/* a = a + d - c; */
		mov a, %eax
		add d, %eax
		sub c, %eax
		mov %eax, a
	
		/* c = c - 1*/
		mov c, %eax
		sub $1, %eax
		mov %eax, c
		
	endif:
	
		
	/* go back to "for" 11 times*/
	add $1, %ecx
	cmp n, %ecx
	jne for
	
end:
	ret
