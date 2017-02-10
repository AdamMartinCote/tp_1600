/**
 * INF1600 - TP4
 * Programmation en assembleur et c++
 * equivalent_acc.s
 * Auteur: Adam Martin-Côté
 * Débuté : 7 novembre 2016
 * Remis : 18 novembre 2016
 */

.data
        two: .float 2.0

.globl _ZNK4CCar16EquivalentAccAsmEv

_ZNK4CCar16EquivalentAccAsmEv:
	push 	%ebp      			/* save old base pointer */
	mov 	%esp, %ebp 			/* set ebp to current esp */
	sub		$4,%esp
	mov		8(%ebp),%eax		/* move this to ebp */

	/*call	_ZNK4CCar12TotalDistAsmEv*/
	push 	%eax
	mov		0(%eax),%ecx		/* vtable to ecx */
	call	*36(%ecx)			/* call TotalDistAsm */

	fld		two
	fmulp
	fld		52(%eax)			/* started */
	fld		52(%eax)
	fmulp
	fdivrp

	leave          				/* restore ebp and esp */
	ret            				/* return to the caller */
