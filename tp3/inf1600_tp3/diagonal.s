/**
 * INF1600 - tp3/diagonal.s
 * auteur: Adam Martin-Cote
 * remise: 6 novembre 2016
 *
 * ebp-4 = r
 * ebp-8 = c
 */
.global matrix_diagonal_asm

matrix_diagonal_asm:
        
	push  	%ebp
	mov   	%esp,%ebp
	sub 	$16, %esp
	movl 	$0, -4(%ebp)
	jmp		end_loop1
start_loop1:
	movl 	$0, -8(%ebp)	/* c = 0 */
	jmp		end_loop2
	
start_loop2:
	/* if c==r */
	movl	-4(%ebp), %eax
	cmp		%eax, -8(%ebp)	/* compare c with r*/
	jne		else

	/* outmatdata[c+r*matorder] = inmatdata[c+r*matorder] */
	/* get inmatdata value */
	mov 	16(%ebp), %eax
	mull	-4(%ebp)
	add 	-8(%ebp), %eax /* eax = c+r*matorder */
	
	mov 	8(%ebp), %ebx
	mov  	(%ebx,%eax,4),%ecx /* ecx = value of indata */
	
	/* send to proper outmatdata */
	mov 	12(%ebp), %ebx
	mov 	%ecx, (%ebx,%eax,4)	/* eax still have the same indice*/
	add 	$1, -8(%ebp) /* c++ */
	jmp		end_loop2
else:
	/* compute indice */
	movl	-4(%ebp), %eax
	mull 	16(%ebp)
	add 	-8(%ebp), %eax
	
	/* get outmatdata address and zero it*/	
	mov		12(%ebp), %ebx
	movl 	$0, (%ebx,%eax,4)
	add 	$1, -8(%ebp)/* c++ */

	
end_loop2:
	mov 	-8(%ebp), %eax
	cmp		%eax, 16(%ebp)
	je		increment
	jmp		start_loop2
increment:
	add 	$1, -4(%ebp)
	
end_loop1:
	mov 	-4(%ebp), %eax		/* check r */
	cmp		%eax, 16(%ebp)
	je		done
	jmp		start_loop1
	
done:
	leave
	ret
   