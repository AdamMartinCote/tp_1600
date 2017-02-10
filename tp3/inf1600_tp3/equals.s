/**
 * INF1600 - tp3/equals.s
 * auteur: Adam Martin-Cote
 * remise: 6 novembre 2016
 */
.globl matrix_equals_asm

matrix_equals_asm:

	push  	%ebp
	mov   	%esp,%ebp
	sub		$4, %esp				/* esp-4 = n */
									
	movl 	16(%ebp), %eax			/* set n to matorder^2 */
	mul		%eax				
	movl 	%eax, -8(%esp)			
	
	movl  	$0, %ecx				/* use ecx as counter (i) */
	jmp   	end_loop1					
start_loop1:	
	mov 	8(%ebp), %eax			/* move inmat1 to eax */
	mov 	12(%ebp),%ebx			/* move inmat2 to ebx */
	mov 	(%eax,%ecx,4), %eax		/* load appropriate offset */
	mov 	(%ebx,%ecx,4), %ebx		/* load appropriate offset */
	cmp		%eax, %ebx

	je 		pair_is_equal

	mov 	$0, %eax
	jmp		end
pair_is_equal:
	add		$1,%ecx	
end_loop1:		
	cmp   	16(%ebp),%ecx
	jl    	start_loop1				
	mov   	$0x1,%eax				/* return 1 */
end:
	leave  
	ret   
	
	