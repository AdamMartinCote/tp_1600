/**
 * INF1600 - tp3/transpose.s
 * auteur: Adam Martin-Cote
 * remise: 6 novembre 2016
 *
 * ebp-4 = r
 * ebp-8 = c
 */
.globl matrix_transpose_asm

matrix_transpose_asm:
	push 	%ebp
	mov		%esp, %ebp
	sub		$8, %esp
	movl	$0, -4(%ebp)
	jmp		end_loop1
start_loop1:
	movl 	$0, -8(%ebp)
	jmp		end_loop2
	
start_loop2:
	/* compute indice of in */
	mov 	-8(%ebp),%eax
	mull	16(%ebp)
	add 	-4(%ebp),%eax
	
	/* get in value */
	mov 	8(%ebp),%ebx
	pushl	(%ebx,%eax,4)
	
	/* compute indice of out */
	mov 	-4(%ebp),%eax
	mull	16(%ebp)
	add 	-8(%ebp),%eax
	
	/* pop the value to out */
	mov 	12(%ebp),%ebx
	popl	(%ebx,%eax,4)
	
	add		$1, -8(%ebp)
	
end_loop2:
	mov 	-8(%ebp), %eax
	cmp		%eax, 16(%ebp)
	je		incrementloop1
	jmp		start_loop2
	
incrementloop1:
	add 	$1, -4(%ebp)
	
end_loop1:
	mov 	-4(%ebp), %eax
	cmp		%eax, 16(%ebp)
	je		done
	jmp		start_loop1
done:	
	leave  
	ret  
	