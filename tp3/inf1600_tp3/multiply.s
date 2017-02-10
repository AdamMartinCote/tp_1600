/**
 * INF1600 - tp3/multiply.s
 * auteur: Adam Martin-Cote
 * remise: 6 novembre 2016
 *
 * ebp-4  = r
 * ebp-8  = c
 * ebp-12 = i
 * ebp-16 = elem
 * 
 * ebp+8  = inmatdata1
 * ebp+12 = inmatdata2
 * ebp+16 = outmatdata
 * ebp+20 = matorder
 */
.globl matrix_multiply_asm

matrix_multiply_asm:
	push  	%ebp
	mov   	%esp,%ebp
	sub   	$16,%esp
	movl	$0,-4(%ebp)
	jmp		end_loop1
	
start_loop1:
	movl	$0,-8(%ebp)
	jmp		end_loop2
	
start_loop2:
	movl	$0,-16(%ebp)
	movl	$0,-12(%ebp)
	jmp		end_loop3
start_loop3:	
	/* compute indice 1 */
	mov		-4(%ebp),%eax
	mull	20(%ebp)
	add 	-12(%ebp),%eax
	/* get data 1 */
	mov		8(%ebp),%ebx
	pushl	(%ebx,%eax,4)
	/* compute indice 2 */
	mov		-12(%ebp),%eax
	mull	20(%ebp)
	add 	-8(%ebp),%eax	
	/* get data 2 */
	mov		12(%ebp),%ebx
	mov		(%ebx,%eax,4),%ebx
	/* multiply and add to elem*/
	popl	%eax
	mull	%ebx
	add 	%eax,-16(%ebp)
	
	add		$1,-12(%ebp)
	
end_loop3:
	mov		-12(%ebp),%eax
	cmp		%eax,20(%ebp)
	je		inc_loop2_senddata
	jmp		start_loop3
	
inc_loop2_senddata:
	/* compute indice c+r*matorder */
	mov		-4(%ebp),%eax
	mull	20(%ebp)
	add		-8(%ebp),%eax
	/* get outmatdata address*/
	mov		16(%ebp),%ebx
	pushl	-16(%ebp)
	pop		(%ebx,%eax,4)
	
	add		$1,-8(%ebp)
	
end_loop2:
	mov		-8(%ebp),%eax
	cmp		%eax,20(%ebp)
	je		inc_loop1
	jmp		start_loop2
	
inc_loop1:
	add 	$1,-4(%ebp)	
	
end_loop1:
	mov 	-4(%ebp),%eax
	cmp		%eax,20(%ebp)
	je		done
	jmp		start_loop1
	
done:	
	leave  
	ret    
		