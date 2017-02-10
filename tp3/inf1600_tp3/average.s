/**
 * INF1600 - tp3/average.s
 * auteur: Adam Martin-Cote
 * remise: 6 novembre 2016
 *
 * ebp-4 = r
 * ebp-8 = elem
 */
.global matrix_column_aver_asm
matrix_column_aver_asm:		
	push  	%ebp
	mov   	%esp,%ebp
	sub   	$0x8,%esp
	
	mov 	$0, %ecx		/* use ecx for first loop */
	jmp		end_loop1
	
start_loop1:
	movl 	$0, -8(%ebp)		/* elem = 0 */
	movl 	$0, -4(%ebp)		/* r = 0 */
	jmp		end_loop2
	
start_loop2:	

	/* elem += inmatdata[c + r * matorder]; */
	mov 	16(%ebp), %eax
	mull	-4(%ebp)
	add		%ecx, %eax			/* c is ecx */
	
	/* add inmatdata[eax] to elem */
	mov 	8(%ebp), %ebx
	mov 	(%ebx,%eax,4), %ebx
	add		%ebx, -8(%ebp)
	
	add		$1, -4(%ebp)		/* increment r */	
	
end_loop2:
	mov 	-4(%ebp), %eax		/* put r in eax */
	cmp		%eax, 16(%ebp)		/* compare r with matorder */

	je 		continue
	jmp		start_loop2
	
continue:	/* outmatdata[c] = elem/matorder*/
	mov		-8(%ebp), %eax
	mov		$0, %edx
	divl	16(%ebp)	
	mov		12(%ebp), %ebx
	mov		%eax, (%ebx,%ecx,4)
	
	add 	$1, %ecx			/* increment ecx for next loop */	
	
end_loop1:
	mov 	16(%ebp), %eax		/* compare matorder with ecx */
	cmp		%eax, %ecx
	je		done
	jmp		start_loop1
	
done:
	leave  
	ret   
	
	